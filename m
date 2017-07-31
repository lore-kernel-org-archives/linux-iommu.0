From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v8 02/13] iommu/amd: add several helper functions
Date: Mon, 31 Jul 2017 12:07:02 +0200
Message-ID: <20170731100702.GJ3431@suse.de>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
 <1500627551-12930-3-git-send-email-bhe@redhat.com>
 <20170727150612.GK3610@suse.de>
 <20170731100111.GA29157@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170731100111.GA29157@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Baoquan,

On Mon, Jul 31, 2017 at 06:01:11PM +0800, Baoquan He wrote:
> I found the event log related handling functions all take
> xxx_event_buffer names, like:
> alloc_event_buffer()
> iommu_enable_event_buffer()
> free_event_buffer()
> 
> So for consistency, I plan to still use iommu_disable_event_buffer().
> Maybe later we can change them in a clean up patch independently.

Yeah, makes sense. Go ahead with it.



	Joerg
