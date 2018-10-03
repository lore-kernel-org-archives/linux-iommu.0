From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 0/4] Add MT7623 dts bindings documentation
Date: Wed,  3 Oct 2018 11:09:08 +0200
Message-ID: <20181003090912.30501-1-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, joro@8bytes.org, arnd@arndb.de
Cc: rick.chang@mediatek.com, bin.liu@mediatek.com, mchehab@kernel.org, matthias.bgg@gmail.com, sboyd@codeaurora.org, sean.wang@mediatek.com, chen.zhong@mediatek.com, weiyi.lu@mediatek.com, ryder.lee@mediatek.com, yong.wu@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Mediateks MT7623 SoC shares most of its component with MT2701.
This series adds devicetree documentation for all the devices.

It applies cleanly against linux next, so I don't expect any merge
conflicts if this is taken by Arnd through the arm-soc tree for v4.20
