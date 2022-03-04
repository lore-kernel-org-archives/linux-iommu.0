Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFB2C433FE
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 15:35:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D092D409C6;
	Fri,  4 Mar 2022 15:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z4jkMcEtV656; Fri,  4 Mar 2022 15:35:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A5DF4409B4;
	Fri,  4 Mar 2022 15:35:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 744DEC001D;
	Fri,  4 Mar 2022 15:35:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68079C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 15:35:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 41299401DD
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 15:35:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V-39ns80GZsH for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 15:35:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7693E400F2
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 15:35:43 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id E18F91CA; Fri,  4 Mar 2022 16:35:39 +0100 (CET)
Date: Fri, 4 Mar 2022 16:35:38 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.17-rc6
Message-ID: <YiIxynRjN0sRPIju@8bytes.org>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5742588208545464093=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5742588208545464093==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sAXEzC0S1am36OTS"
Content-Disposition: inline


--sAXEzC0S1am36OTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.17-rc6

for you to fetch changes up to 9826e393e4a8c3df474e7f9eacd3087266f74005:

  iommu/tegra-smmu: Fix missing put_device() call in tegra_smmu_find (2022-02-28 14:01:57 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.17-rc6

Including:

	- Fix a double list_add() in Intel VT-d code

	- Add missing put_device() in Tegra SMMU driver

	- Two AMD IOMMU fixes:
	  - Memory leak in IO page-table freeing code
	  - Add missing recovery from event-log overflow

----------------------------------------------------------------
Adrian Huang (1):
      iommu/vt-d: Fix double list_add when enabling VMD in scalable mode

Lennert Buytenhek (1):
      iommu/amd: Recover from event log overflow

Miaoqian Lin (1):
      iommu/tegra-smmu: Fix missing put_device() call in tegra_smmu_find

Suravee Suthikulpanit (1):
      iommu/amd: Fix I/O page table memory leak

 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/init.c            | 10 ++++++++++
 drivers/iommu/amd/io_pgtable.c      | 12 ++++++------
 drivers/iommu/amd/iommu.c           | 10 ++++++++--
 drivers/iommu/intel/iommu.c         |  2 +-
 drivers/iommu/tegra-smmu.c          |  4 +++-
 7 files changed, 30 insertions(+), 10 deletions(-)

Please pull.

Thanks,

	Joerg

--sAXEzC0S1am36OTS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmIiMcoACgkQK/BELZcB
GuOVgw//cRwpzihkCZzEyg3UdyLz3/T2+rJukHB+ACyZot/DmB4ygu/SNI5CY2tE
b5gbxBEX8ZiKoobFewhMe+qWi0z9y5FIuuKOOGgnS81XYb89DhedMsIeiTtLNa5m
87BrByk+t9x7Nlo5AHfm8RfpBaRs6ZFewP37twZMdq+MF0lKyl7Af5kFxwol4D7Q
+3oxGHl6zEINYeFB6i+/8hUm0zk4uTOZPdai52HNXbH658Mz07+xi03h7EK0SfWC
y8eJvjUvO/9+JSYdYn7FJiyo8WsV/p+UaxoVQ6sHo6/pmTT7tB/ENsWnzCde+KVB
a2Pali17xmQunUvP74QMHgghf6ebvEcqgIqn8tTrEdNfkcJRp9XrZgVRdYeZlSOX
gjTfqTcoLfkIrnJlfC36zYa4QmXtp6jE9n3D3i8zkGSKVqKu4fRgjyXF2gBBUm03
CTMRZW1Z63HyiDBbZfwwVzMGVhmNKBDAX4xPIiTQwb6yh52a3LhRTQP22mSmnpjp
W4UaJSucKkkpeGvQKwr6Qx9Td2fYCL5tiKdP1u8fH9rAPT9TX1LKZKpncFJE+d/7
kMN62iDnYdOm0AZiWkSQ0Xr5FIbTLfMAqiIAQ3zbt6ujNVl7be20h9ZOvgUeckUX
e6mZHuyhhUT1V/XslRwWldo1TsZC2HYCKsNddQVd6in9B0gr4zY=
=bjSp
-----END PGP SIGNATURE-----

--sAXEzC0S1am36OTS--

--===============5742588208545464093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5742588208545464093==--
