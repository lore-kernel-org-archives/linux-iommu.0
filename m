From: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH 0/9] iommu: clean up/remove modular stuff from non-modules.
Date: Tue, 27 Nov 2018 09:39:12 -0500
Message-ID: <20181127143912.GF14659@windriver.com>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
	<20181127101156.GA12298@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181127101156.GA12298-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Stepan Moskovchenko <stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

[Re: [PATCH 0/9] iommu: clean up/remove modular stuff from non-modules.] On 27/11/2018 (Tue 11:11) Joerg Roedel wrote:

> Hi Paul,
> 
> thanks for your cleanup!
> 
> The iommu-tree uses another rule for the subject line of patches. Can
> you please resend with correct subject lines? See below for what is
> used.

Sure - I'll wait another day or two in case anyone on the Cc sends in
some additional Acks.

Thanks,
Paul.
--

> 
> The general format is:
> 
> 	iommu/<driver>: _C_apital letter starting subject
> 
> Please also collect the Acks you get and add them to the patches before
> the resend.
> 
> On Mon, Nov 26, 2018 at 05:31:29PM -0500, Paul Gortmaker wrote:
> > Paul Gortmaker (9):
> >   iommu: audit and remove any unnecessary uses of module.h
> Fine.
> >   iommu: rockchip: make it explicitly non-modular
> 	iommu/rockchip: Make it explicitly non-modular
> >   iommu: msm_iommu: make it explicitly non-modular
> 	iommu/msm: Make it explicitly non-modular
> >   iommu: mtk_iommu: make it explicitly non-modular
> 	iommu/mediatek: Make it explicitly non-modular
> >   iommu: ipmmu-vmsa: make it explicitly non-modular
> 	iommu/ipmmu-vmsa: Make it explicitly non-modular
> >   iommu: qcom_iommu: make it explicitly non-modular
> 	iommu/qcom: Make it explicitly non-modular
> >   iommu: tegra-gart: make it explicitly non-modular
> 	iommu/tegra: Make it explicitly non-modular
> >   iommu: arm-smmu: make it explicitly non-modular
> 	iommu/arm-smmu: Make arm-smmu explicitly non-modular
> >   iommu: arm-smmu-v3: make it explicitly non-modular
> 	iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular
> 
> Thanks a lot,
> 
>        Joerg
