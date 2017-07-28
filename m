From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v8 10/13] iommu/amd: Allocate memory below 4G for dev
 table if translation pre-enabled
Date: Fri, 28 Jul 2017 13:18:09 +0200
Message-ID: <20170728111809.GC3431@suse.de>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
 <1500627551-12930-11-git-send-email-bhe@redhat.com>
 <20170727155550.GO3610@suse.de>
 <20170728090619.GM24304@x1>
 <20170728111439.GB3431@suse.de>
 <20170728111553.GR24304@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170728111553.GR24304@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 28, 2017 at 07:15:53PM +0800, Baoquan He wrote:
> On 07/28/17 at 01:14pm, Joerg Roedel wrote:
> > Yes, exactly, the first device table also needs to be allocated with
> > GFP_DMA32 so that it ends up below 4GB.
> 
> Got it, will do. Thanks!

Oh, and you also need to check in the kdump kernel whether the old
device-table is really below 4GB and abort the copy otherwise.
