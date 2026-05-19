Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2BA365A0B
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215171; cv=none; b=TJqh3zLjP+TtxW0BucD0M0679Juc1q38TQRbdm0OGe117udA799HO9GIdDd+jBIPy1+KrbfrEOpFltGCRXX6Ll3/gYHrTyqkKuMdxJ6FDy6JRGsar0CO2AsqeqiiA/uVoAgZXBViALlMbPWwiix+Qu+8lErGvVKpt2mSXUiCsR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215171; c=relaxed/simple;
	bh=czRIP9fPYWV1iXkGq8o8sM5pGSyI70HQ0UuHcLUB8gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ie8FYw5uK0UaYPE3LGwS203x/+ImzrdEtyfZpc5lsX74w0pSvy1v41NRtMc7vKpRTSWifsQnpZl7fvsyFu/aJU+koLKBzUsTHclj4oc79EgsINOZkze19pOFaJbCJjbpptZn/j+LjC/LljPP1Of9eBOZlOR/mNDEMh/upnUpI24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pyJcUVWn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pyJcUVWn"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso1935ad.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779215168; x=1779819968; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UztCOzVT9zWGOulxXltF3roIbWFaiwmorl3lCjhP7nc=;
        b=pyJcUVWn/OC0HOEH31Er1qxUVFhexm0hLCs4HjEOMLEG9O2pbxG2tJG7VHXQAKgPeL
         bqHexJu1r6ATYjqggpkjifqGm4yJtG297obcd1RNBqV2/jR7PsvUJfHO7X5POo90ulCS
         35X5Bg3C4E6Q2CAEkTThlWaS15lF6qMAC+T9I5Rq8godKtrpX9YK1mR8BKdv3bg9mYt6
         aMtvhzKhYbtBrhi4uLZytsZlwpY6KBmXeLl0tMTu320IBU4caZLBbXnJ4nd+ymM35T44
         O916ij49CMv5eFP4uZpfj71sCrSqvKLKgVgdo5hqU6xd0RmRgXvQF6rwJMewkDHpAeVX
         huIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779215168; x=1779819968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UztCOzVT9zWGOulxXltF3roIbWFaiwmorl3lCjhP7nc=;
        b=GVUafmXRKsDBLpZeuXhbBfhDTnbSEvaqlJieXquTcZ94ReI9kHsS9GeAFegtH4T69B
         eGDaPEUgqom5sepQv3y51Rm6NsmlgUwNA+4Z3OQ2jk+0X+CCcSwAFoRPtoh60UCm4EwZ
         1te13sTBGqI/iQ040bfEcJL3sL637UdJwEeNGDEDa9kBpl62gGU1QDGecODybqNvc3Yd
         HfjDVVGSLRaoJNDd6X5xwN3TkdBsbIxnlcYjylHrApFkbwGbC1P+KCSK7OCRA8j+oTRN
         7P5PcyeQbsSFE2Y+61vMLWlHZ4Nj5XzcMwDQXJih6EZbs7THysQsQ0fuAPYHPvQeuod3
         yvPw==
X-Forwarded-Encrypted: i=1; AFNElJ9AwP3MGR+JVL1j/112k2bx6MLJuuAGlBPw+v+Qj4QYVsnsx6TekvRu2GZiqvTpoXl6Siqr6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKEoa9xISZPz9SOhfPVPo0pDbzZETH6gmCU5LjvofDmubfON8F
	qbnjsQktbVd8hHJIo6RMUQTcRadjK9E+Pjy3vdyAE4HjwkS2/jbOXinCrZ+2hXt6aw==
X-Gm-Gg: Acq92OFFMlIQLQrCA8jfa2pVfsmPxRBEQQtSDW0vakpH+uNSivAheAWlzMIIjX8bn2O
	d8fEPhUlzO9LYhDRLMcKnX0kyOmSjFLgWUfM9j2VoDC0jSoqfiDUHhZ5HUE1GPBMHsL80HyngR3
	AYATRr2K9yYHeJmDoKfxxN0HyTJp3I0pIFvqqGRqwr9VfAoVKQpmj0bXjr4gfEF1ID+OaWVEcQE
	mG+W0ym9sZ1bnfYgET/swJYHn47PEZiq1tqgQUb+RglTcFR7mxRsOkRp0UNOcLJQKjtQbHlbCHo
	wigLoc/xel3r5Tecz/KDzUJnmX8I314F0YTfh42fkiluv7dWw57OhSS68tzoQ6FoD38ggxYVsKr
	P8JmIn41exAevzVTjbRVujRhT2TXddJhNHz4KGZyn2HhriYodT3HTjQcks6mbWpEFm5YpBZN3FH
	xp4gkD6hXUE8lG3FTjfKQcKhRXjd3mwh6Nx+CH8aPRvLmmJsxW/RbRjKhr7FeezwFG0yAIQw==
X-Received: by 2002:a17:902:e788:b0:2b0:b0c9:96e2 with SMTP id d9443c01a7336-2bdb32c0349mr6068925ad.21.1779215167429;
        Tue, 19 May 2026 11:26:07 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369512424c2sm15165142a91.4.2026.05.19.11.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:26:06 -0700 (PDT)
Date: Tue, 19 May 2026 18:26:03 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 07/16] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <agyMsywb8KqBNu-S@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-8-skhawaja@google.com>
 <a968550d-2cab-47fd-8639-a8747a8a7535@linux.intel.com>
 <af023TAT1m3oA9ez@google.com>
 <agtux6SrjpRYvMit@google.com>
 <agx2RW_jujXbsiea@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agx2RW_jujXbsiea@google.com>

On Tue, May 19, 2026 at 02:40:05PM +0000, Pranjal Shrivastava wrote:
>On Mon, May 18, 2026 at 08:32:42PM +0000, Samiullah Khawaja wrote:
>> On Fri, May 08, 2026 at 02:36:56AM +0000, Samiullah Khawaja wrote:
>> > On Thu, May 07, 2026 at 02:25:14PM +0800, Baolu Lu wrote:
>> > > On 4/28/26 01:56, Samiullah Khawaja wrote:
>> > > > Add implementation of the device and iommu presevation in a separate
>> > > > file. Also set the device and iommu preserve/unpreserve ops in the
>> > > > struct iommu_ops.
>> > > >
>> > > > During normal shutdown the iommu translation is disabled. Since the root
>> > > > table is preserved during live update, it needs to be cleaned up and the
>> > > > context entries of the unpreserved devices need to be cleared.
>> > >
>> > > This is not related to preserve/unpreserve ops and could be made in a
>> > > separated patch?
>> >
>> > Agreed. I will move this stuff to a separate patch.
>> > >
>> > > >
>> > > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> > > > ---
>> > > > MAINTAINERS                      |   1 +
>> > > > drivers/iommu/intel/Makefile     |   1 +
>> > > > drivers/iommu/intel/iommu.c      |  52 +++++++++++-
>> > > > drivers/iommu/intel/iommu.h      |  28 +++++++
>> > > > drivers/iommu/intel/liveupdate.c | 139 +++++++++++++++++++++++++++++++
>> > > > drivers/iommu/iommu.c            |  18 ++++
>> > > > include/linux/iommu-liveupdate.h |  10 +++
>> > > > include/linux/iommu.h            |  14 ++++
>> > > > include/linux/kho/abi/iommu.h    |  18 ++++
>> > > > 9 files changed, 277 insertions(+), 4 deletions(-)
>> > > > create mode 100644 drivers/iommu/intel/liveupdate.c
>> > > >
>>
>> [snip]
>> > >
>> > > > +{
>> > > > +	struct context_entry *context;
>> > > > +	int ret;
>> > > > +	int i;
>> > > > +
>> > > > +	for (i = 0; i < ROOT_ENTRY_NR; i++) {
>> > > > +		/*
>> > > > +		 * Alloc the context tables now to make sure the iommu unit is
>> > > > +		 * properly preserved. These might stay unused and wastes around
>> > > > +		 * 32MB max in scalable mode.
>> > > > +		 */
>> > >
>> > > Instead of allocating and preserving context tables for all root entries
>> > > (as noted, can waste up to 32MB), could we restrict this only to the
>> > > entries possibly in use by active PCI devices?
>> >
>> > I think the hotplug devices or VFs created through SR-IOV will be missed
>> > that way. Lets say device A is preserved and the associated iommu is
>> > also preserved. And then a new device B is hotplugged and preserved,
>> > then the context table for that will be missed.
>>
>> Ok I thought about it a little more and basically we have following
>> things to consider when we preserve context tables,
>>
>> - The devices can be hotplugged and preserved, so the context tables of
>>   those need to be preserved if we don't allocate all of them first time
>>   we preserve iommu, as done here.
>> - New context tables can be added (after hotplug) for unpreserved
>>   devices. And if we don't get another iommu preserve call after these
>>   are added, those remain unpreserved, so during shutdown those entries
>>   need to be removed from root table or preserved for simplicity.
>>
>> To solve this we can,
>>
>> 1. Either preserve the new context table when it is added for a preserved
>>   iommu. This can be done in iommu_context_addr(). This is simpler and
>>   no tracking needed.
>>
>> 2. Or track the preserved context tables using a bitmap and then preserve
>>   them incremently whenever a device is preserved. On shutdown during
>>   cleanup, we can clear the entries for unpreserved context tables from
>>   root table.
>>
>> I am inclined towards second option. WDYT?
>
>Thinking out loud here, I agree that shifting away from the 32MB

Wait it should be 2MB (256 buses * 8K(low + Hi)), I miswrote it earlier.
>pre-allocation is the right direction. I'm wondering if we can avoid the
>overhead of introducing a new tracking bitmap (Option 2) altogether?

ROOT_ENTRY_NR is 256 and has 2 context tables for scalable mode, so the
max bitmap will be eight u64. It is per IOMMU, but still reasonable.
>
>Since the IOMMU serialization is a strict dependency for device tracking,
>could we move the context table preservation directly into the device
>level op: intel_iommu_preserve_device()?
>
>Whenever a specific device is preserved on-demand:
>
>1. It queries the parent IOMMU to fetch the allocated context table
>   backing its info->bus.
>
>2. It calls iommu_preserve_page(context) for that table. Because KHO's
>   tracking handles duplicates, this should be fine if multiple devices
>   reside on the same bus...
>
>Regarding Scalable Mode, we could just need a simple check in that path:
>
>
>/* intel_iommu_preserve_device */
>/* Preserve the primary/lower context table backing this bus */
>context = iommu_context_addr(info->iommu, info->bus, 0, 0);
>if (context)
>	iommu_preserve_page(context);
>
>/* If scalable mode is active, preserve the upper context table as well */
>if (sm_supported(info->iommu)) {
>	context = iommu_context_addr(info->iommu, info->bus, 0x80, 0);
>	if (context)
>		iommu_preserve_page(context);
>}
>
>WDYT?

I was thinking on the same lines and was hinting to it in my earlier
reply to Baolu. But then I didn't go for it as with this approach we
introduce a bunch of complexity or lost state depending on the approach
we take.

Basically like I mentioned, the unpreserved context tables need to be
removed from root table during shutdown. We can find out which ones are
unpreserved by walking the preserved device list yes. But it complicates
the overall preservation lifecycle of these context tables by
introducing multiple preserved device list walks. Basically on every
device unpreserve we will have to decide that whether we unpreserve the
context table or some preserved device is still using it. Or if we
choose to keep it preserved even if the device is unpreserved, then
during cleanup we have no way of differentiation whether a context table
was unpreserved and needs clearing in root table.

The bitmap approach is much simpler and only preserves the context
tables for the active devices as suggested by Baolu earlier. Note with
this approach we preserve the context tables of the active devices and
not only the preserved ones, but since these are recreated after kexec
anyway, so not really a waste as compared to preserving the maximum
possible.
>
>>
>> I think we will have to do similar stuff for PASID also down the road to
>> preserve pasid_tables in PASID directory.
>> >
>> > Since we don't track the context_tables that are preserved, there is no
>> > way to incremently preserve the new-ones. Let me look into the behaviour
>> > of KHO, maybe we can make the preserve call idempotent and do these
>> > incrementally.
>> > >
>> > > > +		spin_lock(&iommu->lock);
>> > > > +		context = iommu_context_addr(iommu, i, 0, 1);
>> > > > +		spin_unlock(&iommu->lock);
>> > > > +		if (!context) {
>> > > > +			ret = -ENOMEM;
>> > > > +			goto error;
>> > > > +		}
>>
>[snip]
>
>Thanks,
>Praan

Sami
