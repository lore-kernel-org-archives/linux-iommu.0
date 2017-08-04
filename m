From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v9 05/13] iommu/amd: Add function copy_dev_tables()
Date: Fri, 4 Aug 2017 14:51:59 +0200
Message-ID: <20170804125159.GY3431@suse.de>
References: <1501587449-9817-1-git-send-email-bhe@redhat.com>
 <1501587449-9817-6-git-send-email-bhe@redhat.com>
 <20170804120908.GT3431@suse.de>
 <20170804123039.GK1874@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170804123039.GK1874@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 04, 2017 at 08:30:39PM +0800, Baoquan He wrote:
> Sorry, I don't get 'this one' meaning, are you suggesting the copy for
> loop should be take out of the iommu for loop? 
> 
> About the temporary copy of the old device-table, you can see in patch
> 7/13, if irq sanity check failed, it return -1. This return could happen
> in the middle of copy. So I think we should do a whole successful copy,
> or don't copy at all. It might not be good do half copy.

No, I mean that you should move the copy of the complete device-table
out of the for_each_iommu() loop. Currently you make sure you copy only
once with the 'copied' flag, but that is not necessary if you move the
code behind the loop.
