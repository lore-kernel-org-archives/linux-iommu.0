From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/4] More cleanups and fixes for Intel VT-d
Date: Fri, 12 Jun 2015 09:31:44 +0200
Message-ID: <20150612073144.GJ20384@8bytes.org>
References: <1434030463-942-1-git-send-email-joro@8bytes.org>
 <1434038066.3907.85.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434038066.3907.85.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: iommu@lists.linux-foundation.org, zhen-hual@hp.com, linux-kernel@vger.kernel.org, bhe@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 11, 2015 at 04:54:26PM +0100, David Woodhouse wrote:
> It looks like the original kdump patch set has basically now been
> rewritten. Perhaps the best thing to do is for Zhenhua to resubmit an
> updated and clean version rather than preserving that
> churn?

Yeah, you are right. The history got really messy and is a horror to
backport. I'll post a clean rewrite of this soon.


	Joerg
