From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 00/12] Support using MSI interrupts in ntb_transport
Date: Tue, 26 Feb 2019 10:34:46 +0100
Message-ID: <20190226093445.GC19617@8bytes.org>
References: <20190213175454.7506-1-logang@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190213175454.7506-1-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 13, 2019 at 10:54:42AM -0700, Logan Gunthorpe wrote:
>   iommu/vt-d: Add helper to set an IRTE to verify only the bus number
>   iommu/vt-d: Allow interrupts from the entire bus for aliased devices

Applied these two to the iommu tree, thanks.
