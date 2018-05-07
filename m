From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 4/4] iommu/tegra: gart: Optimize map/unmap
Date: Mon, 7 May 2018 10:04:20 +0200
Message-ID: <20180507080420.GB18595@8bytes.org>
References: <cover.1523304324.git.digetx@gmail.com>
	<f21a7b6a8f141b87f75687904a76f3728ea639a8.1523304324.git.digetx@gmail.com>
	<20180427100202.GO30388@ulmo>
	<716edf58-38a7-21e5-1668-b866bf392e34@arm.com>
	<6827bda3-1aa2-da60-a749-8e2dd2e595f3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6827bda3-1aa2-da60-a749-8e2dd2e595f3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, May 07, 2018 at 12:19:01AM +0300, Dmitry Osipenko wrote:
> Probably the best variant would be to give an explicit control over syncing to a
> user of the IOMMU API, like for example device driver may perform multiple
> mappings / unmappings and then sync/flush in the end. I'm not sure that it's
> really worth the hassle to shuffle the API right now, maybe we can implement it
> later if needed. Joerg, do you have objections to a 'compound page' approach?

Have you measured the performance difference on both variants? The
compound-page approach only works for cases when the physical memory you
map contiguous and correctly aligned.

If it is really needed I would prefer a separate iotlb_sync_map()
call-back that is just NULL when not needed. This way all users that
don't need it only get a minimal penalty in the mapping path and you
don't have any requirements on the physical memory you map to get good
performance.


	Joerg
