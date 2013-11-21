From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv5 4/9] iommu/tegra: smmu: register device to iommu
	dynamically
Date: Thu, 21 Nov 2013 15:38:45 +0200
Message-ID: <20131121153845.e37c01b2f384883e3611790a@nvidia.com>
References: <1384853593-32202-1-git-send-email-hdoyu@nvidia.com>
	<1384853593-32202-5-git-send-email-hdoyu@nvidia.com>	<528BDAAA.4000203@
	wwwdotorg.org>	<20131121132322.EFDD1C40A2C@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131121132322.EFDD1C40A2C-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 21 Nov 2013 14:23:22 +0100
Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> > > +static int smmu_iommu_add_device(struct device *dev)
> > > +{
> > > +	int err = -EPROBE_DEFER;
> > > +	u32 swgroups = dev->platform_data;
> > > +	struct dma_iommu_mapping *map = NULL;
> > > +
> > > +	if (test_bit(TEGRA_SWGROUP_PPCS, swgroups))
> > > +		map = smmu_handle->map[SYSTEM_PROTECTED];
> > > +	else
> > > +		map = smmu_handle->map[SYSTEM_DEFAULT];
> > > +
> > > +	if (map)
> > > +		err = arm_iommu_attach_device(dev, map);
> > > +	else
> > > +		return -EPROBE_DEFER;
> > 
> > Given that patch 2 exists, if this test fails, then surely the
> > appropriate error code is some fatal error, not -EPROBE_DEFER; any
> > deferrals should have happened long before this point.
> 
> Will need to be revisited. Patching into the core really_probe() like
> patch #2 does is a really bad approach which would mean that returning
> EPROBE_DEFER is appropriate here.

I'm going to send PATCHv6, where it's a little bit easier to discuss
further since some code are cleaned up with feedback.

We once discussed to make use of bus_notifier instead of embedding a
hook in really_probe(). This would require some change where
bus_notifer return code needs to be used to postpone device
population.
