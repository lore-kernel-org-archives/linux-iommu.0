From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3] iommu/s390: Add support for iommu_device handling
Date: Fri, 11 Aug 2017 09:31:18 +0200
Message-ID: <20170811073118.GF30515@8bytes.org>
References: <1502274354-643-1-git-send-email-joro@8bytes.org>
 <alpine.LFD.2.20.1708102104390.4919@schleppi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1708102104390.4919@schleppi>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

Hey Sebastian,

On Thu, Aug 10, 2017 at 09:07:06PM +0200, Sebastian Ott wrote:
> With this patch pci hot-unplug fails with a use after free or refcounting
> issue - I'm currently trying to understand what's going on...

Let me know if I can help with debugging the issue, do you have a
backtrace for me to look at?


Regards,

	Joerg
