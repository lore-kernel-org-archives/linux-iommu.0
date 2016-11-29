From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 04/16] drivers: iommu: make of_iommu_set/get_ops() DT
	agnostic
Date: Tue, 29 Nov 2016 17:05:49 +0100
Message-ID: <20161129160549.GH2078@8bytes.org>
References: <20161109141948.19244-5-lorenzo.pieralisi@arm.com>
	<20161111152248.GS2078@8bytes.org>
	<552e674a-f434-f08f-8e16-a94544ce8e6e@arm.com>
	<20161111162736.GV2078@8bytes.org>
	<33769e3c-265f-6e89-adf9-6d35b1e03579@arm.com>
	<20161114102654.GA1677@red-moon>
	<41e3eff1-9ce6-bcfb-5716-c65ef38add63@arm.com>
	<20161114155222.GZ2078@8bytes.org>
	<313844ca-d948-1297-84b2-669f3a7d57d2@arm.com>
	<20161116095615.GA25656@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161116095615.GA25656@red-moon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Dennis Chen <dennis.chen-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Prem Mallappa <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 16, 2016 at 09:56:15AM +0000, Lorenzo Pieralisi wrote:
> I can easily make the changes Robin suggests above, I need to know
> what to do with this patch it is the last blocking point for this
> series and time is running out I can revert to using dev->bus to
> retrieve iommu_ops (even though I do not think it makes sense given
> what Robin outlines below) but I need to know please, we can't gate
> an entire series for this patch that is just syntactic sugar.

Well, I didn't really object to the approach per-se, I just wanted to
know the rationale behind the need for the iommu-ops pointer. So through
which tree should this series be merged?
I think I can live with the pointer for now, we can later convert it to
an iommu-instance pointer.


	Joerg
