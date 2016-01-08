From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 5/6] iommu/amd: Add support for non-pci devices
Date: Fri, 8 Jan 2016 13:18:56 +0100
Message-ID: <20160108121855.GU18805@8bytes.org>
References: <1451988444-4694-1-git-send-email-vincent.wan@amd.com>
 <1451988444-4694-6-git-send-email-vincent.wan@amd.com>
 <20160107120422.GB19149@8bytes.org>
 <CAKT61h9retMxx8JiWEHYRVkX7ROXVvsYDJ3WZDoL17YhdjJdBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKT61h9retMxx8JiWEHYRVkX7ROXVvsYDJ3WZDoL17YhdjJdBA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: Wan Zongshun <vincent.wan@amd.com>, linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, Ray Huang <ray.huang@amd.com>, Borislav Petkov <bp@suse.de>, ken.xue@amd.com, vw@iommu.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 08, 2016 at 11:15:37AM +0800, Wan ZongShun wrote:
> Please see the following function, since I judge this
> 'get_acpihid_device_id(dev, NULL) < 0'  in the front of
> 'get_device_id', so your concern should not exist. I have already
> filtered the negative situation in check_device firstly, do you think
> it is ok?
> 
> 
> static bool check_device(struct device *dev)
> {
>         u16 devid;
> ......
> 
>         /* No PCI device */
>         if (!dev_is_pci(dev) && (get_acpihid_device_id(dev, NULL) < 0))
>                 return false;
> 
>         devid = get_device_id(dev);

That is true for this case, but the other call-sites of get_device_id()
still have to care about a potential negative return value, right?



	Joerg
