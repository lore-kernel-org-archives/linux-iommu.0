From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC] iommu: arm-smmu: stall support
Date: Wed, 27 Sep 2017 16:35:34 +0200
Message-ID: <20170927143534.GQ8398@8bytes.org>
References: <20170914194444.32551-1-robdclark@gmail.com>
 <20170919123038.GF8398@8bytes.org>
 <CAF6AEGuutkqjrWk4jagE=p-NwHgxdiPZjjsaFsfwtczK568j+A@mail.gmail.com>
 <20170922090204.GJ8398@8bytes.org>
 <32e3ab2c-a996-c805-2a0d-a2e85deb3a50@arm.com>
 <CAF6AEGuh0FiNWEAmFm+7-7pc6MV5hKKz9cyA_J0d256bY-nYOQ@mail.gmail.com>
 <20170927121540.GL8398@8bytes.org>
 <4e2fc08e-3e7e-3355-17e5-72106196c732@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4e2fc08e-3e7e-3355-17e5-72106196c732@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Rob Clark <robdclark@gmail.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jean,

On Wed, Sep 27, 2017 at 02:49:00PM +0100, Jean-Philippe Brucker wrote:
> I like this approach. When the device driver registers a fault handler,
> it also tells when it would like to be called (either in atomic context,
> blocking context, or both).

Is there a use-case for calling the same handler from both contexts?

> enum iommu_fault_status {
>         IOMMU_FAULT_STATUS_NONE = 0,
>         IOMMU_FAULT_STATUS_FAILURE,
>         IOMMU_FAULT_STATUS_INVALID,
>         IOMMU_FAULT_STATUS_HANDLED,
>         IOMMU_FAULT_STATUS_IGNORE,
> };


This all certainly makes sense for the PRI/PASID case, but I don't think
that it makes sense yet to extend the existing report_iommu_fault()
interface to also handle PASID/PPR faults.

The later needs a lot more parameters to successfully handle a fault. In
the AMD driver these are all in 'struct fault', the relevant members
are:

        u64 address;
        u16 devid;
        u16 pasid;
        u16 tag;
        u16 finish;
        u16 flags;

And passing all this through the existing interface which also handles
non-pasid faults is cumbersome. So I'd like to keep the PASID/PPR
interface separate from the old one for now.

Regards,

	Joerg
