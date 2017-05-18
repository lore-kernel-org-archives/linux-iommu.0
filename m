From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [Qemu-devel] [RFC PATCH 5/8] VFIO: Add new IOTCL for PASID Table
	bind propagation
Date: Thu, 18 May 2017 12:29:27 +0100
Message-ID: <d75f198a-8589-a9d7-cc48-9b92c3d5e3b7@arm.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-6-git-send-email-yi.l.liu@intel.com>
	<20170512155851.627409ed@t450s.home> <20170517102759.GF22110@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170517102759.GF22110-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 17/05/17 11:27, Liu, Yi L wrote:
> On Fri, May 12, 2017 at 03:58:51PM -0600, Alex Williamson wrote:
>> On Wed, 26 Apr 2017 18:12:02 +0800
>> "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>>>  
>>> +/* IOCTL for Shared Virtual Memory Bind */
>>> +struct vfio_device_svm {
>>> +	__u32	argsz;
>>> +#define VFIO_SVM_BIND_PASIDTBL	(1 << 0) /* Bind PASID Table */
>>> +#define VFIO_SVM_BIND_PASID	(1 << 1) /* Bind PASID from userspace driver */
>>> +#define VFIO_SVM_BIND_PGTABLE	(1 << 2) /* Bind guest mmu page table */
>>> +	__u32	flags;
>>> +	__u32	length;
>>> +	__u8	data[];
>>
>> In the case of VFIO_SVM_BIND_PASIDTBL this is clearly struct
>> pasid_table_info?  So at a minimum this is a union including struct
>> pasid_table_info.  Furthermore how does a user learn what the opaque
>> data in struct pasid_table_info is without looking at the code?  A user
>> API needs to be clear and documented, not opaque and variable.  We
>> should also have references to the hardware spec for an Intel or ARM
>> PASID table in uapi.  flags should be defined as they're used, let's
>> not reserve them with the expectation of future use.
>>
> 
> Agree. would add description accordingly. For the flags, I would remove
> the last two as I wouldn't use. I think Jean would add them in his/her
> patchset. Anyhow, one of us need to do merge on the flags.

Yes, I can add the VFIO_SVM_BIND_PASID (or rather _TASK) flag as (1 << 1)
in my series if it helps the merge. The PGTABLE flag is for another series
which I don't plan to send out anytime soon, since there already is enough
pending work on this.

Thanks,
Jean
