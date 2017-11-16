From: Bharat Kumar Gogada <bharatku@xilinx.com>
Subject: RE: [RFCv2 PATCH 31/36] iommu/arm-smmu-v3: Add support for PCI ATS
Date: Thu, 16 Nov 2017 14:19:36 +0000
Message-ID: <BLUPR0201MB150565029F9260A528739ACBA52E0@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-32-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171006133203.22803-32-jean-philippe.brucker@arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>, "liubo95@huawei.com" <liubo95@huawei.com>, "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>, xieyisheng1@huawei.co
List-Id: iommu@lists.linux-foundation.org

Hi Jean,

+static size_t
+arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
+			unsigned long iova, size_t size)
+{
+	unsigned long flags;
+	struct arm_smmu_cmdq_ent cmd;
+	struct arm_smmu_master_data *master;
+
+	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, list)
+		arm_smmu_atc_inv_master(master, &cmd);
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+	return size;
+}
+
 /* IOMMU API */
 static bool arm_smmu_capable(enum iommu_cap cap)  { @@ -2361,6 +2506,8 @@ =
static void arm_smmu_detach_dev(struct device *dev)
 		__iommu_process_unbind_dev_all(&smmu_domain->domain, dev);
=20
 	if (smmu_domain) {
+		arm_smmu_atc_inv_master_all(master, 0);
+
In BIND flow, when VFIO_IOMMU_UNBIND is invoked invalidation is sent on all=
ocated PASID for this application.
When vfio group fd is closed after UNBIND,  arm_smmu_detach_dev is invoked =
now invalidation is being sent on ssid zero.
Why  invalidation needs to be sent on ssid zero ?

Regards,
Bharat

