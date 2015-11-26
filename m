From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/s390: fix sparse warnings
Date: Thu, 26 Nov 2015 14:41:54 +0100
Message-ID: <20151126134154.GA17674@8bytes.org>
References: <alpine.LFD.2.11.1511061723260.2646@denkbrett>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1511061723260.2646@denkbrett>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 06, 2015 at 05:26:24PM +0100, Sebastian Ott wrote:
> Fix these warnings:
>   CHECK   drivers/iommu/s390-iommu.c
> drivers/iommu/s390-iommu.c:52:21: warning: symbol 's390_domain_alloc' was not declared. Should it be static?
> drivers/iommu/s390-iommu.c:76:6: warning: symbol 's390_domain_free' was not declared. Should it be static?
> 
> Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>

Applied, thanks.
