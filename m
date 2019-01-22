From: "Frank Wunderlich" <frank-w@public-files.de>
Subject: [BUG] "access dev->iommu_fwspec" cause crash on BPI-R2
Date: Tue, 22 Jan 2019 17:09:09 +0100
Message-ID: <trinity-76e7f2ce-27ce-4f3b-809f-7da9a35e5210-1548173349245@3c-app-gmx-bs21>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Ryder Lee <ryder.lee@mediatek.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

the following Patch breaks hdmi (at least) on Bananapi R2 (mt7623):

a9bf2eec5a6fc01a0a5250eaf0bf61dfd382a78a "iommu/mediatek: Use helper functions to access dev->iommu_fwspec"

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/iommu/mtk_iommu_v1.c?id=a9bf2eec5a6fc01a0a5250eaf0bf61dfd382a78a

[    5.363509] Backtrace:                                                                      
[    5.365946] [<c05a6010>] (mtk_iommu_domain_free) from [<c05a1544>] (iommu_domain_free+0x20/)
[    5.374670]  r4:decd57a0                                                                    
[    5.377192] [<c05a1524>] (iommu_domain_free) from [<c011b85c>] (release_iommu_mapping+0x24/)
[    5.385922] [<c011b838>] (release_iommu_mapping) from [<c011b8cc>] (arm_iommu_release_mappi)
[    5.395943]  r7:00000000 r6:decd5780 r5:00000000 r4:decd57a0                                
[    5.401567] [<c011b89c>] (arm_iommu_release_mapping.part.0) from [<c011cb4c>] (arch_setup_d)
[    5.411412]  r5:00000000 r4:dead1410                                                        
[    5.414968] [<c011ca7c>] (arch_setup_dma_ops) from [<c07d2764>] (of_dma_configure+0x27c/0x3)
[    5.423521]  r6:c0b58e20 r5:00000000 r4:00000000                                            
[    5.428109] [<c07d24e8>] (of_dma_configure) from [<c060a63c>] (platform_dma_configure+0x28/)
[    5.436838]  r10:c107efdc r9:00000000 r8:c10c0008 r7:00000000 r6:c1117b34 r5:dead1410       
[    5.444612]  r4:c1117b30                                                                    
[    5.447131] [<c060a614>] (platform_dma_configure) from [<c06079ec>] (really_probe+0xc4/0x42)
[    5.455602] [<c0607928>] (really_probe) from [<c0607f70>] (driver_probe_device+0x88/0x1e0)  
[    5.463814]  r10:00000000 r9:c060a25c r8:00000000 r7:c1008c48 r6:c107efdc r5:c107efdc       
[    5.471588]  r4:dead1410                                                                    
[    5.474107] [<c0607ee8>] (driver_probe_device) from [<c06081fc>] (__driver_attach+0x134/0x1)
[    5.482663]  r9:c060a25c r8:00000000 r7:c1008c48 r6:c107efdc r5:dead1444 r4:dead1410        
[    5.490358] [<c06080c8>] (__driver_attach) from [<c0605510>] (bus_for_each_dev+0x84/0xc4)   
[    5.498480]  r7:c1008c48 r6:c06080c8 r5:c107efdc r4:00000000                                
[    5.504102] [<c060548c>] (bus_for_each_dev) from [<c0607344>] (driver_attach+0x2c/0x30)     
[    5.512052]  r7:c10bff30 r6:c107fad8 r5:decde780 r4:c107efdc                                
[    5.517675] [<c0607318>] (driver_attach) from [<c0606c68>] (bus_add_driver+0x1d0/0x274)     
[    5.525629] [<c0606a98>] (bus_add_driver) from [<c0608fa8>] (driver_register+0x84/0x118)    
[    5.533666]  r8:c060a20c r7:c0609c60 r6:c10c0230 r5:00000002 r4:c107efdc                    
[    5.540323] [<c0608f24>] (driver_register) from [<c060a538>] (__platform_register_drivers+0)

after reverting it i can boot without crash and start x-server

my repo just for reference (revert not pushed yet): https://github.com/frank-w/BPI-R2-4.14/tree/5.0-hdmi

i hope i had chosen the right way to report this...

regards Frank
