From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd - Use dev_err to send events to the system log
Date: Tue, 13 Feb 2018 17:00:18 +0100
Message-ID: <20180213160018.fg7baclgu5o5rgxc@8bytes.org>
References: <151736066756.21649.4739957712713863861.stgit@sosam4>
 <20180213132216.gyhndywyu23cdzbv@8bytes.org>
 <325d7406-e01b-f7a1-3da6-390b0cf9bc94@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <325d7406-e01b-f7a1-3da6-390b0cf9bc94@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Hook, Gary" <ghook@amd.com>
Cc: Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 13, 2018 at 10:47:55AM -0500, Hook, Gary wrote:
> 
>         dev_err(&iommu->dev->dev, "ILLEGAL...

I think its more something like iommu->iommu->dev.


	Joerg
