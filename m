From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 04/22] iommu/vt-d: add bind_pasid_table function
Date: Wed, 6 Jun 2018 12:20:51 +0100
Message-ID: <2831caf1-d40b-58c3-313c-afb7262e1861@arm.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-5-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180417131047.0a9c310f@w520.home>
	<AM4PR0802MB2369F739C91B630CA99B3D3BA3B40@AM4PR0802MB2369.eurprd08.prod.outlook.com>
	<20180420164251.5245f822@jacob-builder>
	<20180529140915.1f174689@w520.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D1911E59C4@SHSMSX101.ccr.corp.intel.com>
	<20180529211746.74f1dd23@w520.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D1911E5F06@SHSMSX101.ccr.corp.intel.com>
	<a07a0a0a-ebdd-c81a-7ed6-cff19e6078d7@arm.com>
	<20180530125240.34e0e80c@jacob-builder>
	<1c1094e8-ecbb-7731-910c-59e4de1e5c70@arm.com>
	<20180605103253.634ef8fd@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180605103253.634ef8fd@jacob-builder>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Wysocki,
	Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 05/06/18 18:32, Jacob Pan wrote:
>> "bytes" could be passed by VFIO as argument to bind_pasid_table, since
>> it can deduce it from argsz
>>
> Are you suggesting we wrap this struct in a vfio struct with argsz? or
> we directly use this struct?
> 
> I need to clarify how vfio will use this.

Right, I think we've diverged a bit since the last discussion :)

> - User program:
> struct pasid_table_config ptc = { .bytes = sizeof(ptc) };
> ptc.version = 1;
> ioctl(device, VFIO_DEVICE_BIND_PASID_TABLE, &ptc);

Any reason to do the ioctl on device instead of container? As we're
binding address spaces we probably want a consistent view for the whole
container, like the MAP/UNMAP ioctls do.

As I remember it the userspace interface would use a VFIO header and the
BIND ioctl. I can't find the email in my archive though, so I might be
imagining it. This is what I remember, on the user side:

struct {
	struct vfio_iommu_type1_bind	hdr;
	struct pasid_table_config	cfg;
} bind = {
	.hdr.argsz	= sizeof(bind),
	.hdr.flags	= VFIO_IOMMU_BIND_PASID_TABLE,
	/* cfg data here */
};

ioctl(container, VFIO_DEVICE_BIND, &bind);


But I don't feel strongly about the interface. However I'd suggest to
keep incremental versioning like the rest of VFIO, with argsz and flags,
instead of version numbers, because it's more flexible.

Initially the PTC struct would look like:
struct pasid_table_config {
  u32 argsz;		/* sizeof(pasid_table_config) */
  u32 flags;		/* Should be zero */
  u64 base_ptr;
  u8 model;
  u8 pasid_bits;
};

(Even though it doesn't use a version field let's call this version 1
for the sake of the example)

------
If someone wants to add a new field to the structure, then they also add
a flag (let's call this version 2):

struct pasid_table_config {
  u32 argsz;
#define PASID_TABLE_CONFIG_EXTN (1 << 0)
  u32 flags;
  u64 base_ptr;
  u8 model;
  u8 pasid_bits;
  u64 some_extension;
};

* Assume user has a version 2 header and kernel has a version 1 header.
  * If user doesn't want the extension, it doesn't set the EXTN flag.
    The ioctl succeeds because the kernel checks that argsz >=
    offsetofend(pasid_bits) and that (flags == 0).
  * If user wants to use the extension, it sets the EXTN flag. The ioctl
    fails because the kernel doesn't recognize the flag.
* Assume user has version 1 and kernel has version 2.
  * User doesn't use the extension. The kernel still checks that
    argsz >= offsetofend(pasid_bits), but also that (flags &
    ~PASID_TABLE_CONFIG_EXTN), which succeeds.
  * User wants the extension, sets PASID_TABLE_CONFIG_EXTN. When
    seeing the flag, the kernel additionally checks that argsz >=
    offsetofend(some_extension), which succeeds.

------
Adding model-specific fields is a bit more complicated, because I think
they should always stay at the end of the struct. One solution is to add
padding for common extensions:

struct pasid_table_config {
  u32 argsz;
  u32 flags;
  u64 base_ptr;
  u8 model;
  u8 pasid_bits;
  u8 padding[64];

  union {
    struct {
      u8 s1dss;
      u8 s1fmt;
    } model_arm;
    struct {
      u64 foo;
    } model_bar;
  };
};

(we might call this version 3, but can be added before or after version
2, it doesn't matter)

A subsequent extension can still add the "some_extension" field and a
flag. If the kernel sees model "ARM", then it checks argsz >=
offsetofend(model_arm). If it sees model "BAR" then it checks argsz >=
offsetofend(model_bar). A model could also have flags to make the
model-specific structure extensible.

The problem is when we run out of space in the padding area, but we
might not need much extensibility in the common part.

Thanks,
Jean
