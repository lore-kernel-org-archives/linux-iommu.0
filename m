From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
Date: Tue, 23 Apr 2019 16:57:21 +0200
Message-ID: <20190423145721.GH29810@8bytes.org>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
 <20190418234828.GG126710@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190418234828.GG126710@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Srinath Mannam <srinath.mannam@broadcom.com>, Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Scott Branden <sbranden@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 18, 2019 at 06:48:28PM -0500, Bjorn Helgaas wrote:
> To make progress on this, I think we need an ack from Joerg for the
> dma-iommu.c part, an ack from Ray or Scott for the pcie-iproc.c part,
> and an ack from Robin for the thing as a whole.

I wait for Robin to review the dma-iommu change. If he is okay with it,
I am too.


	Joerg
