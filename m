From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 03/40] iommu/sva: Manage process address spaces
Date: Thu, 24 May 2018 14:50:39 +0300
Message-ID: <20180524115039.GA10260@apalos>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-4-jean-philippe.brucker@arm.com>
 <20180516163117.622693ea@jacob-builder>
 <de478769-9f7a-d40b-a55e-e2c63ad883e8@arm.com>
 <20180522094334.71f0e36b@jacob-builder>
 <f73b4a0e-669e-8483-88d7-1b2c8a2b9934@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f73b4a0e-669e-8483-88d7-1b2c8a2b9934@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "xuzaibo@huawei.com" <xuzaibo@huawei.com>, "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, Will Deacon <Will.Deacon@arm.com>, "okaya@codeaurora.org" <okaya@codeaurora.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "ashok.raj@intel.com" <ashok.raj@intel.com>, "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>, "robdclark@gmail.com" <robdclark@gmail.com>, "bharatku@xilinx.com" <bharatku@xilinx.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "liudongdong3@huawei.com" <liudongdong3@huawei.com>, "rfranz@cavium.com" <rfranz@cavium.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "kevin.tian@intel.com" <kevin.tia>
List-Id: iommu@lists.linux-foundation.org

> Interesting, I hadn't thought about this use-case before. At first I
> thought you were talking about mdev devices assigned to VMs, but I think
> you're referring to mdevs assigned to userspace drivers instead? Out of
> curiosity, is it only theoretical or does someone actually need this?

There has been some non upstreamed efforts to have mdev and produce userspace
drivers. Huawei is using it on what they call "wrapdrive" for crypto devices and
we did a proof of concept for ethernet interfaces. At the time we choose not to
involve the IOMMU for the reason you mentioned, but having it there would be
good.

Thanks
Ilias
