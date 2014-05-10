From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH v2 00/15] PCI/iommu: Fix DMA alias problems
Date: 10 May 2014 12:16:36 -0400
Message-ID: <20140510161636.25044.qmail@ns.horizon.com>
References: <1399731309.17639.167.camel@ul30vt.home>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1399731309.17639.167.camel@ul30vt.home>
Sender: linux-pci-owner@vger.kernel.org
To: alex.williamson@redhat.com, linux@horizon.com
Cc: acooks@gmail.com, bhelgaas@google.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

> I'll post a v3 soon, I think we figured out the problem Andrew was
> having, a couple typos on my part.  I'll push out a new branch for that
> so you don't need to piece it together yourself.  Thanks,

Don't worry; I imported v2, and have it running successfully right now.
I ran e2fsck and hdparm -t on a couple of drives on the controller
(including in parallel), with no problems.

Again, sorry for my earlier laziness.
