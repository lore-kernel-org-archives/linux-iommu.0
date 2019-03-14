From: James Sewart <jamessewart@arista.com>
Subject: [PATCH v2 4/7] iommu/vt-d: Ignore domain parameter in attach_device
 if  device requires identity map
Date: Thu, 14 Mar 2019 11:58:43 +0000
Message-ID: <D8A19A7A-91CB-4297-9445-47DB248B7817@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

If a device requires an identity map then it is not safe to attach a
domain that can remap addresses. Warn the user if this occurs.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/iommu/intel-iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2e00e8708f06..104d36f225a7 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5101,6 +5101,11 @@ static int intel_iommu_attach_device(struct =
iommu_domain *domain,
 		}
 	}
=20
+	if (iommu_no_mapping(dev)) {
+		dmar_domain =3D si_domain;
+		dev_warn(dev, "VT-d: Device is required to use identity =
IOMMU mapping, ignoring domain attached\n");
+	}
+
 	iommu =3D device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
 		return -ENODEV;
--=20
2.17.1
