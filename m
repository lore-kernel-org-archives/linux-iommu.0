From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 5/6] iommu/amd: Add support for non-pci devices
Date: Wed, 20 Jan 2016 13:00:09 +0100
Message-ID: <20160120120008.GC18805@8bytes.org>
References: <1451988444-4694-1-git-send-email-vincent.wan@amd.com>
 <1451988444-4694-6-git-send-email-vincent.wan@amd.com>
 <20160107120422.GB19149@8bytes.org>
 <CAKT61h9retMxx8JiWEHYRVkX7ROXVvsYDJ3WZDoL17YhdjJdBA@mail.gmail.com>
 <20160108121855.GU18805@8bytes.org>
 <568FCD4B.4000807@iommu.org>
 <20160108170145.GW18805@8bytes.org>
 <5690D723.7020003@iommu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5690D723.7020003@iommu.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wan Zongshun <vw@iommu.org>
Cc: Wan Zongshun <vincent.wan@amd.com>, linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, Ray Huang <ray.huang@amd.com>, Borislav Petkov <bp@suse.de>, ken.xue@amd.com
List-Id: iommu@lists.linux-foundation.org

Hi Vincent,

On Sat, Jan 09, 2016 at 05:47:15PM +0800, Wan Zongshun wrote:
> If so we will modify some existing amd iommu driver codes, and Can I
> merge those into this patch 5/6? or I will create another dedicated
> patch to take this action?

I think its best to make a seperate patch which makes the call-sites of
get_device_id() aware of negative return values. Please queue this patch
before the patch that actually converts get_device_id() to return
something negative.


	Joerg
