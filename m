From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Intel-IOMMU: Delete an error message for a failed memory
	allocation in init_dmars()
Date: Sun, 21 Jan 2018 08:19:04 +0100
Message-ID: <20180121071903.GD28161@8bytes.org>
References: <def26d40-37d3-d594-e17c-53e40a3034b7@users.sourceforge.net>
	<20180120133452.GB28161@8bytes.org>
	<6b452dfb-b2fc-2417-26b3-bbcdf11ed06f@users.sourceforge.net>
	<20180120194004.GC28161@8bytes.org>
	<1516498672.24895.2.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1516498672.24895.2.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
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
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Jan 20, 2018 at 05:37:52PM -0800, Joe Perches wrote:
> While Markus' commit messages are nearly universally terrible,
> is there really any signficant value in knowing when any
> particular OOM condition occurs other than the subsystem that
> became OOM?
> 
> You're going to be hosed in any case.
> 
> Why isn't the generic OOM stack dump good enough?

Because if we know the exact allocation attempt that failed right away,
we can more easily check if we can rewrite it so that it is more likely
to succeed, e.g. rewriting one higher-order allocation to multiple
order-0 allocations.


	Joerg
