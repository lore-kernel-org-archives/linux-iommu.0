From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC 0/3] iommu/iova: Unsafe locking in find_iova()
Date: Fri, 6 Jul 2018 15:16:11 +0200
Message-ID: <20180706131611.h3w2kdinmjguikgo@8bytes.org>
References: <20180621180823.805-1-dima@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180621180823.805-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Safonov <dima@arista.com>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, Dmitry Safonov <0x7f454c46@gmail.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 21, 2018 at 07:08:20PM +0100, Dmitry Safonov wrote:
> find_iova() looks to be using a bad locking practice: it locks the
> returned iova only for the search time.  And looking in code, the
> element can be removed from the tree and freed under rbtree lock. That
> happens during memory hot-unplug and cleanup on module removal.  Here
> I cleanup users of the function and delete it.

But this is only a problem if more than one code-path uses tries to
handle a given iova at the same time, no?

Regards,

	Joerg
