From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 04/16] drivers: iommu: make of_iommu_set/get_ops() DT
	agnostic
Date: Mon, 14 Nov 2016 16:52:23 +0100
Message-ID: <20161114155222.GZ2078@8bytes.org>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
	<20161109141948.19244-5-lorenzo.pieralisi@arm.com>
	<20161111152248.GS2078@8bytes.org>
	<552e674a-f434-f08f-8e16-a94544ce8e6e@arm.com>
	<20161111162736.GV2078@8bytes.org>
	<33769e3c-265f-6e89-adf9-6d35b1e03579@arm.com>
	<20161114102654.GA1677@red-moon>
	<41e3eff1-9ce6-bcfb-5716-c65ef38add63@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41e3eff1-9ce6-bcfb-5716-c65ef38add63-5wv7dgnIgG8@public.gmane.org>
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
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Dennis Chen <dennis.chen-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Prem Mallappa <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 14, 2016 at 12:00:47PM +0000, Robin Murphy wrote:
> If we've already made the decision to move away from bus ops, I don't
> see that it makes sense to deliberately introduce new dependencies on
> them. Besides, as it stands, this patch literally implements "tell the
> iommu-core which hardware-iommus exist in the system and a seperate
> iommu_ops ptr for each of them" straight off.

Not sure which code you are looking at, but as I see it we have only
per-device iommu-ops now (with this patch). That is different from
having core-visible hardware-iommu instances where devices could link
to.

Also the rest of iommu-core code still makes use of the per-bus ops. The
per-device ops are only used for the of_xlate fn-ptr.



	Joerg
