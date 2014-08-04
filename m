From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/vt-d: Do not BUG_ON in intel_unmap if no domain
Date: Mon, 4 Aug 2014 13:49:48 +0200
Message-ID: <20140804114948.GA8172@suse.de>
References: <1407151386-16467-1-git-send-email-joro@8bytes.org>
 <20140804114205.GA5545@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140804114205.GA5545@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 04, 2014 at 01:42:05PM +0200, Borislav Petkov wrote:
> It is always questionable when people remove BUG_ONs because relaxing
> assertions sound like a temporary fix more often than not. Sounds to me
> that the original commit which deals with BUS_NOTIFY_DEL_DEVICE needs to
> try again with the fix. :-)

Right, but the "real" fix would be to add a bus notifier that is called
after the device driver released the device and use this one instead of
BUS_NOTIFY_DEL_DEVICE.

But that change wouldn't be suitable for -stable and just removing the
event handler for BUS_NOTIFY_DEL_DEVICE would cause resource leakage
again on hotplug, so I think this "fix" is the best for now.

We can re-add the BUG_ON when we have a real fix upstream.


	Joerg
