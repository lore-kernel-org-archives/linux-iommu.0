From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/dmar: fix buffer overflow during PCI bus
 notification
Date: Tue, 26 Feb 2019 11:25:27 +0100
Message-ID: <20190226102527.GF20740@8bytes.org>
References: <20190220164630.11087-1-julia@ni.com>
 <20190220191744.GC1076@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190220191744.GC1076@jcartwri.amer.corp.natinst.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Cartwright <julia@ni.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 20, 2019 at 07:17:45PM +0000, Julia Cartwright wrote:
> On Wed, Feb 20, 2019 at 10:46:31AM -0600, Julia Cartwright wrote:
> > -	size = sizeof(*info) + level * sizeof(struct acpi_dmar_pci_path);
> > +	size = sizeof(*info) + level * sizeof(info->path[0]);
> 
> This is probably a candidate for struct_size() instead, if that's what
> is preferred.

No, patch is fine as-is. Thanks a lot, applied to iommu/fixes branch.


	Joerg
