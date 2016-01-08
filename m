From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/6] iommu/amd: Add support for non-pci devices
Date: Fri, 8 Jan 2016 18:01:45 +0100
Message-ID: <20160108170145.GW18805@8bytes.org>
References: <1451988444-4694-1-git-send-email-vincent.wan@amd.com>
	<1451988444-4694-6-git-send-email-vincent.wan@amd.com>
	<20160107120422.GB19149@8bytes.org>
	<CAKT61h9retMxx8JiWEHYRVkX7ROXVvsYDJ3WZDoL17YhdjJdBA@mail.gmail.com>
	<20160108121855.GU18805@8bytes.org> <568FCD4B.4000807@iommu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <568FCD4B.4000807-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wan Zongshun <vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ray Huang <ray.huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, ken.xue-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 08, 2016 at 10:52:59PM +0800, Wan Zongshun wrote:
> Actually I am supposing the '.add_device' will be the first called
> in iommu initializing stage, so I think as long as having no error
> of check device here, any call-sites of get_device_id() will be
> fine, because adding device successfully should be the pre-condition
> of any iommu function can be performed, please correct me.
> 
> static int amd_iommu_add_device(struct device *dev)
> {
> 	struct iommu_dev_data *dev_data;
> 	struct iommu_domain *domain;
> 	struct amd_iommu *iommu;
> 	u16 devid;
> 	int ret;
> 
> 	if (!check_device(dev) || get_dev_data(dev))
> 		return 0;
> 
> 	devid = get_device_id(dev);
> 	iommu = amd_iommu_rlookup_table[devid];

There are places in the interrupt remapping code that call get_device_id
without calling check_device first. See get_irq_domain and get_devid.


	Joerg
