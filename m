From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/4] iommu: Consolitate ->add/remove_device() calls
Date: Wed, 5 Dec 2018 16:14:20 +0100
Message-ID: <20181205151420.GA16835@8bytes.org>
References: <20181205143646.4876-1-joro@8bytes.org>
 <20181205143646.4876-3-joro@8bytes.org>
 <20181205145418.GA14251@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181205145418.GA14251@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 05, 2018 at 06:54:18AM -0800, Christoph Hellwig wrote:
> > +void  iommu_release_device(struct device *dev)
> 
> Nitpick: there seems to be a double space here.
> 
> > +int iommu_probe_device(struct device *dev);
> > +void  iommu_release_device(struct device *dev);
> 
> .. and here.

Right, thanks. I fixed it in my development branch.
