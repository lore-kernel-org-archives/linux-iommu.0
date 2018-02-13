From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] amd/iommu: Use raw locks on atomic context paths
Date: Tue, 13 Feb 2018 14:18:53 +0100
Message-ID: <20180213131853.qf2benuztfdihiew@8bytes.org>
References: <20180121092854.28290-1-swood@redhat.com>
	<20180121092854.28290-2-swood@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180121092854.28290-2-swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Luis Claudio R. Goncalves" <lgoncalv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Clark Williams <williams-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Myron Stowe <myron.stowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, Jan 21, 2018 at 03:28:54AM -0600, Scott Wood wrote:
> Several functions in this driver are called from atomic context,
> and thus raw locks must be used in order to be safe on PREEMPT_RT.
> 
> This includes paths that must wait for command completion, which is
> a potential PREEMPT_RT latency concern but not easily avoidable.
> 
> Signed-off-by: Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c       | 30 +++++++++++++++---------------
>  drivers/iommu/amd_iommu_init.c  |  2 +-
>  drivers/iommu/amd_iommu_types.h |  4 ++--
>  3 files changed, 18 insertions(+), 18 deletions(-)

Applied, thanks.
