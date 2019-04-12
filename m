From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 1/1] iommu: Bind process address spaces to devices
Date: Fri, 12 Apr 2019 16:59:54 +0200
Message-ID: <20190412145954.GD29810@8bytes.org>
References: <20190410151516.47754-1-jean-philippe.brucker@arm.com>
 <20190410151516.47754-2-jean-philippe.brucker@arm.com>
 <20190411152803.GB29810@8bytes.org>
 <aa213d61-2351-73f4-629c-08a18320fbec@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <aa213d61-2351-73f4-629c-08a18320fbec@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "christian.koenig@amd.com" <christian.koenig@amd.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>, "ashok.raj@intel.com" <ashok.raj@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
List-Id: iommu@lists.linux-foundation.org

Hey Jean-Philippe,

On Fri, Apr 12, 2019 at 01:23:51PM +0100, Jean-Philippe Brucker wrote:
> I pushed a cleaner version to git://linux-arm.org/linux-jpb.git sva/api
> (with the below mistake fixed as well) and can resend if necessary.

No need to do that, I solved the conflicts I've seen and compile-testing
looked good so far, so I've pushed it out already. Maybe you can
double-check my tree if everything is as it should be?

Regards,

	Joerg
