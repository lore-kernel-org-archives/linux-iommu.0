From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH 03/37] iommu/sva: Manage process address spaces
Date: Tue, 10 Apr 2018 14:53:47 -0400
Message-ID: <04d4d161-ed72-f6b6-9b94-1d60bd79ef94@codeaurora.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-4-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180212183352.22730-4-jean-philippe.brucker@arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: mark.rutland@arm.com, xieyisheng1@huawei.com, ilias.apalodimas@linaro.org, catalin.marinas@arm.com, xuzaibo@huawei.com, jonathan.cameron@huawei.com, will.deacon@arm.com, yi.l.liu@intel.com, lorenzo.pieralisi@arm.com, ashok.raj@intel.com, tn@semihalf.com, joro@8bytes.org, bharatku@xilinx.com, rfranz@cavium.com, lenb@kernel.org, jacob.jun.pan@linux.intel.com, alex.williamson@redhat.com, robh+dt@kernel.org, thunder.leizhen@huawei.com, bhelgaas@google.com, shunyong.yang@hxt-semitech.com, dwmw2@infradead.org, liubo95@huawei.com, rjw@rjwysocki.net, jcrouse@codeaurora.org, robdclark@gmail.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com, christian.koenig@amd.com, nwatters@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
> +static void io_mm_detach_all_locked(struct iommu_bond *bond)
> +{
> +	while (!io_mm_detach_locked(bond));
> +}
> +

I don't remember if I mentioned this before or not but I think this loop
needs a little bit relaxation with yield and maybe an informational message
with might help if wait exceeds some time.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
