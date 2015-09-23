From: chenfeng <puck.chen@hisilicon.com>
Subject: How to ensure that different peripherals getting different IOVA
 address in kernel?
Date: Wed, 23 Sep 2015 09:55:58 +0800
Message-ID: <560206AE.4020608@hisilicon.com>
References: <5600AF72.2000106@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5600AF72.2000106@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, rcallicotte@gmail.com, robin.murphy@arm.com, jiang.liu@linux.intel.com
Cc: Dan zhao <dan.zhao@hisilicon.com>, qijiwen <qijiwen@hisilicon.com>, Peter Panshilin <peter.panshilin@hisilicon.com>, Suzhuangluan <suzhuangluan@hisilicon.com>, Yiping Xu <xuyiping@hisilicon.com>, "Wangfei (William, Euler)" <w.f@huawei.com>
List-Id: iommu@lists.linux-foundation.org

Hi all,

In IOMMU architecture , how to make two different peripherals share the=
 same page table ?

In other words , is there a mechanism or structure to make two peripher=
als get completely different address.

eg:

peri-A=E3=80=81peri-B and peri-C share the same iova address 0-1G for s=
ome performance requests.

So the A,B,C need to use the same IOVA generator to ensure this,but I d=
on't find an architecture to make this.

Any help will be appreciated.

Puck
