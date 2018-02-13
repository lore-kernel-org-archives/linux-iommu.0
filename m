From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd - Use dev_err to send events to the system log
Date: Tue, 13 Feb 2018 14:22:16 +0100
Message-ID: <20180213132216.gyhndywyu23cdzbv@8bytes.org>
References: <151736066756.21649.4739957712713863861.stgit@sosam4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <151736066756.21649.4739957712713863861.stgit@sosam4>
Sender: linux-kernel-owner@vger.kernel.org
To: Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 30, 2018 at 07:04:27PM -0600, Gary R Hook wrote:
> +		dev_err(dev, "ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x "
> +			"address=0x%016llx flags=0x%04x]\n",
> +			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> +			address, flags);

That prints the PCI device-name of the IOMMU in front of the message. Is
that actually helpful?

If at all, we should print the name of the iommu-device in front of the
message, not the PCI device that hosts the IOMMU.


Thanks,

	Joerg
