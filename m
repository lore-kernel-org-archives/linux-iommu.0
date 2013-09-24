From: Andreas Herrmann <andreas.herrmann@calxeda.com>
Subject: [PATCH 0/7]: iommu/arm-smmu: Misc fixes/adaptions
Date: Tue, 24 Sep 2013 17:06:54 +0200
Message-ID: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
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
To: Will Deacon <will.deacon@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi,

Following patches fix misc issues, that I've seen when using arm-smmu
driver with MMU-400.

I also suggest to add an option to automatically create domains for
each master of detected SMMUs. (Similar to what is available for other
iommu driver(s).)

Comments welcome.


Regards,

Andreas

PS: Patches are against v3.12-rc1-336-gd8524ae (and yes I probably
    need to rebase against Joerg's or your smmu tree but I wanted to
    sent this out to get feedback as soon as possible.)
