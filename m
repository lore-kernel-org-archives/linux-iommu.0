From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 08/16] iommu: introduce device fault data
Date: Tue, 10 Oct 2017 14:43:59 -0700
Message-ID: <20171010144359.73060dea@jacob-builder>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1507244624-39189-9-git-send-email-jacob.jun.pan@linux.intel.com>
        <439401c0-a9ff-a69a-dc10-12d72f7abbab@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <439401c0-a9ff-a69a-dc10-12d72f7abbab@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Tue, 10 Oct 2017 20:29:29 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> > +enum iommu_model {
> > +	IOMMU_MODEL_INTEL = 1,
> > +	IOMMU_MODEL_AMD,
> > +	IOMMU_MODEL_SMMU3,
> > +};  
> 
> Now unused, I guess?

right, missed it. thanks
