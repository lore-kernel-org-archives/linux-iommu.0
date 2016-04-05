From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] iommu/rockchip: Only log stall errors when attaching
Date: Tue, 05 Apr 2016 10:10:48 -0700
Message-ID: <2124490.J3euH9zgZk@phil>
References: <1458659073-13553-1-git-send-email-tomeu.vizoso@collabora.com>
	<20160405145726.GD11519@8bytes.org> <7194078.9M5myMDU4z@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <7194078.9M5myMDU4z@phil>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Am Dienstag, 5. April 2016, 09:48:15 schrieb Heiko Stuebner:
> Am Dienstag, 5. April 2016, 16:57:26 schrieb Joerg Roedel:
> > On Tue, Mar 22, 2016 at 04:04:33PM +0100, Tomeu Vizoso wrote:
> > > Move the logging of timeouts when stalling the MMU to
> > > rk_iommu_attach_device, as it's expected that sometimes the MMU won't
> > > get stalled when detaching a device, and it's not a real problem that
> > > would need to be communicated to the user.
> > > 
> > > Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> > 
> > Heiko, any opinion on this patch?
> 
> I don't know enough about iommus (and the rockchip implementation) to
> judge if this is correct. The reasoning sound right though and it seems
> to fix an issue for Tomeu.
> 
> One complaint would be that I'd expect the behaviour to match between the
> enable and disable functions. Meaning I'd want the error message from
> rk_iommu_disable_stall to also move rk_iommu_attach_device.

hmm, or does John's patch maybe tie into this problem?

Aka, does the iommu simply does not detect when it's already stalled and 
emits the timeout then?

Tomeu, in which cases do you see the excess error message?
