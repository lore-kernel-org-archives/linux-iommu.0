From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: fix missing tag from dev_err message
Date: Fri, 6 Jul 2018 15:00:24 +0200
Message-ID: <20180706130024.GD13903@8bytes.org>
References: <1540588259.84011.1530637026831@ox-groupware.bfs.de>
	<cb5702b95b8d4914612526125f625c4bc2cedfcc.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cb5702b95b8d4914612526125f625c4bc2cedfcc.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: "Hook, Gary" <ghook-5C7GfCeVMHo@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Walter Harms <wharms-fPG8STNUNVg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 03, 2018 at 10:34:12AM -0700, Joe Perches wrote:
> On Tue, 2018-07-03 at 18:57 +0200, Walter Harms wrote:
> > It is only cosmetics but even the author got lost about the loose bracket.
> > I would suggest to remove all the brackets or if needed to move the [ in the
> > message. We have enought memory this days.
> 
> My suggestion would be to remove the separate dev_err
> and use "Event log [" in each dev_err.
> 
> So here's an actual suggested patch that does a few things:
> 
> o Coalesce formats and realigns arguments
> o Uses pr_fmt and dev_fmt to prefix "AMD-Vi: " to all messages
> o Remove embedded "AMD-Vi: " from various formats

Nice cleanup! But I got lost a bit in the patches floating around in
this thread and their dependencies. Can someone sort it out and send it
a new patch-set to me?


Thanks,

	Joerg
