From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/4 v2] Implement access checks in iommu page fault paths
Date: Fri, 27 Nov 2015 13:07:52 +0100
Message-ID: <20151127120751.GJ24300@8bytes.org>
References: <1447773099-2444-1-git-send-email-joro@8bytes.org>
 <564CA3C4.60609@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <564CA3C4.60609@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: iommu@lists.linux-foundation.org, Oded Gabbay <oded.gabbay@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hey Jesse,

On Wed, Nov 18, 2015 at 08:13:56AM -0800, Jesse Barnes wrote:
> 
> I might be able to find time later this week or next; I have to update
> my tree to David's latest bits and rebase my i915 code on top along with
> these patches.  Then I can run some of my tests and expand them to try
> r/w tests w/o mapping the buffer with the right access mode.

Have you found time to run some small tests on this?


Thanks,

	Joerg
