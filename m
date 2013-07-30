From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 14/22] iommu/tegra: smmu: Register platform_device to
	IOMMU dynamically
Date: Tue, 30 Jul 2013 08:18:03 +0300
Message-ID: <20130730081803.5bb0ed4665f1f6ecf5dab908@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
	<1373021097-32420-15-git-send-email-hdoyu@nvidia.com>
	<51E84D51.2030404@wwwdotorg.org>
	<20130729.142752.1020949402019811407.hdoyu@nvidia.com>
	<51F6AC41.30007@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <51F6AC41.30007-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 29 Jul 2013 19:54:09 +0200
Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
...
> >> Why hard-code this mapping? Can't devices be assigned to ASIDs based on
> >> a DT property? I assume there's nothing in the SMMU HW that requires
> >> specific ASIDs to be used?
> > 
> > Right. Where should those policy be passed, board DT files?
> 
> Is the HW module (== SW group?) to ASID mapping policy or is a
> particular mapping required by HW?

only policy.
But swgroup can have multiple HWs, they need to be set in the same swgroup.

> Can the ASID mapping just happen dynamically in SW rather than DT
> dictating a particular mapping?

No info about ASID in DT, at least, right now.
If a board DT file is the place to put policy, then it can be an option.
 
> I assume the mapping must be set up before any HW is used, and can't be
> modified later, so there's no much chance of deferring any policy
> decisions to user-space etc.?

I think that both cases are needed.

Some traditional devices(MMC) can be changed later as it may have rootfs on it.
For some smarter devices like host1x, it want to change ASID dynamically per request/context.
