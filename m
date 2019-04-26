From: Qian Cai <cai@lca.pw>
Subject: "iommu/amd: Set exclusion range correctly" causes smartpqi offline
Date: Fri, 26 Apr 2019 10:52:28 -0400
Message-ID: <1556290348.6132.6.camel@lca.pw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jroedel@suse.de
Cc: iommu@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Applying some memory pressure would causes smartpqi offline even in today's
linux-next. This can always be reproduced by a LTP test cases [1] or sometimes
just compiling kernels.

Reverting the commit "iommu/amd: Set exclusion range correctly" fixed the issue.

[  213.437112] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0x1000 flags=0x0000]
[  213.447659] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0x1800 flags=0x0000]
[  233.362013] smartpqi 0000:23:00.0: controller is offline: status code 0x14803
[  233.369359] smartpqi 0000:23:00.0: controller offline
[  233.388915] print_req_error: I/O error, dev sdb, sector 3317352 flags 2000001
[  233.388921] sd 0:0:0:0: [sdb] tag#95 UNKNOWN(0x2003) Result: hostbyte=0x01
driverbyte=0x00
[  233.388931] sd 0:0:0:0: [sdb] tag#95 CDB: opcode=0x2a 2a 00 00 55 89 00 00 01
08 00
[  233.389003] Write-error on swap-device (254:1:4474640)
[  233.389015] Write-error on swap-device (254:1:2190776)
[  233.389023] Write-error on swap-device (254:1:8351936)

[1] /opt/ltp/testcases/bin/mtest01 -p80 -w
