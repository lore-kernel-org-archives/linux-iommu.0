From: raymond pang <raymondpangxd@gmail.com>
Subject: vt-d/iommu: RMRR-declared ACPI device handling in current VT-d Driver
Date: Thu, 13 Dec 2018 01:14:56 +0800
Message-ID: <CAHG4imOadbc2QNckBPj0dT3=SJ3nR_0JsWOCTUbBesKrEw_Kcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, dwmw2@infradead.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Dear Joerg & David,
I have a question about current VT-d driver. I found it can not handle
following case:
An RMRR-declared ACPI device (it's also declared by ANDD) cannot
work using current VT-d driver. its DMAs will be blocked by VT-d.
The reason is that current VT-d driver only tries to setup identity map
for devices in dmar_rmrr_unit->device[]. But it doesn't add
RMRR-declared ACPI device into dmar_rmrr_unit->device[]. It just
allocates memory space for this ACPI device in dmar_parse_one_rmrr().
Let's see RMRR-declared PCI device. VT-d driver allocates memory
space for it and then adds it into dmar_rmrr_unit->device[] via
dmar_iommu_notify_scope_dev().
If there is any mistake, please correct me. Thanks

BRs,
Raymond
