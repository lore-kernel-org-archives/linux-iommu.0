From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu: Tidy up window attributes
Date: Tue, 25 Sep 2018 14:55:23 +0200
Message-ID: <20180925125522.mzwsiao3ekqvcsuq@8bytes.org>
References: <96e8371cc3143a58c7a142d9ff1134ba7331dd0a.1537351779.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <96e8371cc3143a58c7a142d9ff1134ba7331dd0a.1537351779.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 19, 2018 at 11:12:57AM +0100, Robin Murphy wrote:
> The external interface to get/set window attributes is already
> abstracted behind iommu_domain_{get,set}_attr(), so there's no real
> reason for the internal interface to be different. Since we only have
> one window-based driver anyway, clean up the core code by just moving
> the DOMAIN_ATTR_WINDOWS handling directly into the PAMU driver.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> Just a cleanup opportunity I spotted whilst poking around in the area.
> 
>  drivers/iommu/fsl_pamu_domain.c | 20 ++++++++++++++++++++
>  drivers/iommu/iommu.c           | 20 --------------------
>  2 files changed, 20 insertions(+), 20 deletions(-)

Nice cleanup, applied both patches, thanks Robin.
