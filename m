From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 06/10] iommu/amd: Add functions
 copy_command_buffer/copy_event_buffer
Date: Sat, 10 Oct 2015 20:24:24 +0800
Message-ID: <20151010122424.GA31787@dhcp-16-116.nay.redhat.com>
References: <1443076656-31776-1-git-send-email-bhe@redhat.com>
 <1443076656-31776-7-git-send-email-bhe@redhat.com>
 <20150929160439.GN3036@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150929160439.GN3036@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 09/29/15 at 06:04pm, Joerg Roedel wrote:
> On Thu, Sep 24, 2015 at 02:37:32PM +0800, Baoquan He wrote:
> > Copy command buffer and event buffer from the old to kdump kernel.
> > 
> > Still there are 2 problems:
> >   1) Not very sure if this is necessary. If do not copy the old command buffer, and
> > only set the newly allocated command buffer, is there anything wrong?
> 
> No, there is no need to copy command and event buffers. Just make sure
> they get re-initialized and flush all iommu caches after setting the new
> device table.

Thanks for your reviewing.

I did a lot of tests. Seems that it doesn't matter with copy or without
a copy. And it's also OK even completely ignore the command buffer and
event log handling here.

Thanks
Baoquan
