Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9D1AD4B
	for <iommu@lists.linux.dev>; Tue, 18 Jul 2023 12:36:29 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7659db6339eso246078185a.1
        for <iommu@lists.linux.dev>; Tue, 18 Jul 2023 05:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689683788; x=1692275788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tkLDZ1Mr27s0sPeIuDfD7KYm9+yHWcDi6GnlbhqN7uk=;
        b=n69pRQs6r7Vw0LXAJNk5h4dKhD4a/JEkC1/ZDTsP5Mds+6djZz8oqlg3rzISbEf7m7
         kMQTNc92LCdLkKLPV6qEUApKa4OZB0SHTPJoFfhD7z4rGopFXsP5K4KIOqDSAB1Xvz5q
         2paWbqe8A3CFVJS8C2srFhqcvl6oGjDFkFtdMQ6WI5xvSfF+R02ue0DsKIEV3xKtrGiW
         DGPxQjr0c5TszyXEs6Pu4y7YhcK9DySeRjEm1JoKN/R1/1+HS/8Cdu9aoel9+7iFFK6Y
         2QI/DOas67A9T4TTCmG9LnWJxW/OtPz3LjCkr55kM/Q1UdukimID8kHyOhVY+/LiLvzZ
         8a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689683788; x=1692275788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkLDZ1Mr27s0sPeIuDfD7KYm9+yHWcDi6GnlbhqN7uk=;
        b=SskaSm+zHJuVWPcdBGEk/r8Txp3N8ll1GrVDbmxaUfXyb+3n7MWYZXDEG7mU38V8zo
         f6XsQVUCaNA/MMKmHZQI7pGpJxcP+X9frBfw7YK+wg3V5f+1o0jLWraJJ8az8EqyI85N
         PL2IZ43I4pCAvhJkFOpZ3/yhB5pjOCHXzQJwaLaO8LOYzAaNk+7AP3JRMuRwsnkBo5Jw
         CrWJV0sgaIz4jCDidsB0ZFUiOP1pWXk3ifzuYNigf+jcSc4fOz47dP+ax2EQ684TAPTz
         BdpWW9rSXhewTNWauZvC5gsH7aL9xg+R68duptLZthacHUjvu4M98mLgAH4wRaqW7gFP
         thCA==
X-Gm-Message-State: ABy/qLbbiGwCIkYpYG9fWyXDdkrrXIDfO652d+WQMrzdLMpNSF+0WaKO
	MkWFLyxDww8OAjnlh7ws7NNwTA==
X-Google-Smtp-Source: APBJJlH2m/KJZixFoXN0eypDQBDA960wXJ9P1Yj3a2iOLQCTOBRpy6Xxgm3pt9mPK++/l8YAhr2bWw==
X-Received: by 2002:a05:620a:178e:b0:765:3c4a:6237 with SMTP id ay14-20020a05620a178e00b007653c4a6237mr14397303qkb.16.1689683788558;
        Tue, 18 Jul 2023 05:36:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id p25-20020a05620a113900b00767cee76155sm547842qkk.55.2023.07.18.05.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 05:36:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qLjwJ-002V8k-3w;
	Tue, 18 Jul 2023 09:36:27 -0300
Date: Tue, 18 Jul 2023 09:36:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org
Subject: Re: [PATCH 11/21] iommu/amd: Clean up and enhance protection domain
 flags
Message-ID: <ZLaHS5bWAu1yjqoW@ziepe.ca>
References: <20230712141516.154144-1-vasant.hegde@amd.com>
 <20230712141516.154144-12-vasant.hegde@amd.com>
 <ZLGFH6qERiRbD6cd@ziepe.ca>
 <db7fe0f7-77d9-f898-0503-d6da58cf25c6@amd.com>
 <ZLUyzrmRKhz4wwQ0@ziepe.ca>
 <1b5b9a47-0e4c-927c-c19a-9ee05ef66918@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b5b9a47-0e4c-927c-c19a-9ee05ef66918@amd.com>

On Mon, Jul 17, 2023 at 11:38:44PM -0700, Suthikulpanit, Suravee wrote:

> Then we need a way to distinguish whether the v2 table is:
>  * Managed by IOMMU driver for DMA-API, which supports only PASID=0.

There is not even such a thing.

The driver should have an iommu domain. It should have and indication
if it is PAGING or BLOCKING/IDENTITY. For PAGING domains you have an
indication of the IOPTE format.

"DMA-API" is a PAGING domain with v1 or v2 IOPTEs
UNMANAGED is the same, a PAGING domain with v1 or v2 IOPTEs
SVA is a "PAGING" domain with v2 IOPTEs
"AMD IOMMUv2 API" is PAGING domain with v2 IOPTEs

The core code provides two actions for the driver, attach domain to
RID, attach domain to PASID.

If you attach a V1 PAGING domain to a RID then you have to put it in
the DTE

If you attach a V2 PAGING domain to a RID then you have to put it in
PASID 0 within a shared GCR3 table. The GCR3 table is NOT part of the
struct protection_domain.

The descision how to configure the DTE/GCR3 is based only on *how and
what domains are attached*.

Doing this wrong is why the driver that that weird mess with trying to
have two different versions of the identity domain.

> What if we introduce a struct protection_domain.gcr3_flags, and use it to
> track information for setting up DTE and GCR3 table for the following
> scenarios.

It is still logically wrong, the GCR3 table has nothing to do with
the driver's iommu_domain. The iommu domain is only about the IOPTEs
contained within it, not the GCR3 table.

> CASE 1:
> -------
> When boot w/ "iommu=nopt amd_iommu=pgtable_v2", the device would be setup to
> support DMA-API with AMD IOMMU v2 page table with PASID=0 in the GCR3 table
> for this domain (i.e. DTE[GIOV]=1).
> 
> Here, we can set:
>   pd_mode    = AMD_IOMMU_PD_MODE_V2;
>   gcr3_flags = AMD_IOMMU_GCR3_FLAG_GIOV;   /* bit 0 */,

As above, the alloc_domain will return a PAGING domain with v2 IOPTEs.

The core will request to install it in the RID

The driver will allocate a shared GCR3 "PASID table" for the RID and
install that in the DTE. Then it will install the PAGING domain in the
PASID0 slot.

> CASE 2:
> -------
> Following case 1, the device driver calls
> iommu_dev_enable_feature(IOMMU_DEV_FEAT_SVA) and iommu_sva_bind_device().
>
> Here, we need to maintain DMA-API mapping from case 1. We would keep the
> GCR3 table from case 1, and bind IOMMU v2 page table from mm_struct to a
> non-zero PASID in the same GCR3 table for SVA support. This is possible
> because the kernel manages PASID-space starting from PASID=1.

Again no issue, the core code does alloc_sva, it returns a "PAGING"
domain with v2 IOPTE format. It does a PASID attach. The driver
ensures the shared GCR3 table is loaded to the DTE and then assigns
the SVA domain to the correct PASID slot.

>  - The AMD_IOMMU_GCR3_FLAGS_MANAGED_PASID is cleared when the domain no
> longer contain SVA-enabled devices.

There is no such thing as "a domain contains devices"
 
> CASE 3:
> -------
> Current default behavior for IOMMU group with PASID/PRI capable device is to
> setup the device in pass-through mode.
> 
> Here, we can set
>   pd_mode = AMD_IOMMU_PD_MODE_PT;
> 
> Subsequently, when calling amd_iommu_bind_pasid(), the IOMMU driver would
> set
>   pd_mode    = AMD_IOMMU_PD_MODE_V2;
>   gcr3_flags = AMD_IOMMU_GCR3_FLAG_UNMANAGED_PASID;	/* bit 2 */

The core code will call alloc_domain with IDENTITY and attach it to
the RID.

This should be a DTE setup for IDENTITY.

Later something will alloc_domain an UNMANGED domain for the PASID !=0 
with v2 IOPTEs.

When the UNMANAGED domain is assigned to the PASID the driver asserts
the shared GCR3 table is loaded. Since the RID is attached to IDENTITY
it computes a DTE that keeps IDENTITY working (GIOV=0, right?). It
then loads the V2 UNAMANGED domain to the correct PASID in the shared
GCR3.

>  - Since kernel does not manage PASIDs for v2API, and the device driver is
> responsible for providing a PASID when calling amd_iommu_bind_pasid(), we
> cannot reserve PASID 0 for non-PASID device. Therefore, device in this group
> would set DTE[GIOV]=0.

The core code works this way too. PASID0 should be kept reserved in
both APIs to make RID devices easier. Driver should refuse to attach a
domain to PASID 0.

>  - We cannot have case 1 or 2 with case 3 in the same IOMMU group since GCR3
> table is currently per-group/domain (i.e. one default domain per-group).

This is the same design mistake smmuv3 made. The GCR3 table must not
be part of the iommu_domain otherwise you end up being stuck and
unable to replace the RID domain, which is breaking the API contract
from the core code.

The GCR3 table must be shared, and must not be part of the
iommu_domain related memory.

Once done like this you can freely mix cases 1/2/3 dynamically
because the GCR3 table is not stored in the wrong place.

>  - TBD: Despite the upcoming SVA support, we still need to maintain support
> for the existing AMD v2 API (which we might consider deprecating in the
> future and put on bug-fix mode only), and we cannot break existing device
> drivers.

Er, no, you need to eliminate the AMD v2 API as part of this work. We
cannot have a private API that duplicates the normal core API that is
only used by AMD GPU. This is the kernel, so we don't maintain
"APIs". You update the in-tree AMDGPU driver to use the core API and
then you purge the old API.

> > GCR3 is the "PASID table" right? it should not be part of the
> > iommu_domain struct either, SMMUv3 is busy undoing this mistake in
> > their design right now.
> 
> GCR3 table is the same as PASID table,
>
> Could you please elaborate on this part if it should not be as part of the
> domain? What's the new design for SMMUv3?

There is a long thread, all the same concepts apply here, the
underlying HW flow is basically the same, just with different names
(STE=DTE, CD=GCR3, S2=V1, S1=V2)

https://lore.kernel.org/linux-iommu/20230621063825.268890-1-mshavit@google.com

And prior postings.

> However, devices in the same domain can share the same mapping
> (e.g. a domain w/ multiple non-PASID capable devices would share the
> same IOMMU v2 page table w/ PASID=0 for DMA-API support). This is
> why we have struct protection_domain.gcr3_tbl to avoid duplicate
> GCR3 table for these devices.

The domain is the wrong place to put this. If you want to share the
GCR3 table between DTEs in the same group then use
iommu_group_get_iommudata() to associate the shared table with the
group.

> Alternatively, If we don't care about the additional memory to setup
> per-device GCR3 table, we could move gcr3_tbl, gcr3_flags, and any related
> variables to the per-device struct iommu_dev_data, which contains
> device-specific data for AMD IOMMU driver.

This is what Michael is proposing for SMMUv3.

Keep in mind that the core code now basically blocks use of PASID for
typical multi-device group scenarios. So you should think carefully if
AMD actually has a use case for multiple DTE's sharing the same GCR3
table that is worth optimizing for.

> > > > > +#define PD_FLAG_GIOV		BIT(4) /* domain enable GIOV support */
> > > > 
> > > > This really shouldn't be a iommu_domain flag, this should be computed
> > > > based on what domains are attached where
> > > > 
> > > > Eg this seems like it should be triggered by attaching identity to the
> > > > RID with PASID enabled or something like that.
> 
> Actually, I am not sure that I understand this point.

GIOV controls what happens to PASID-less TLPs.

One option is to translate through the DTE, which for the 
kernel owned configuration is IDENTITY.

Another option is to translate through the GCR3 PASID 0 v2 PAGING
domain.

The driver selects the correct GIOV value based on what is attached to
the RID. IDENTITY or PAGING will decide what GIOV should be.

Jason
