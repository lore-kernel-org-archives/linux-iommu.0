From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Fix for Linux v4.13-rc4
Date: Fri, 11 Aug 2017 17:57:00 +0200
Message-ID: <20170811155654.GA16219@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Artem Savkov <asavkov@redhat.com>
List-Id: iommu@lists.linux-foundation.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 74ddda71f44c84af62f736a77fb9fcebe5bb436a:

  iommu/amd: Fix schedule-while-atomic BUG in initialization code (2017-07-26 15:39:14 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.13-rc4

for you to fetch changes up to a7990c647b35415e3dd07a077480a908678947ba:

  iommu/arm-smmu: fix null-pointer dereference in arm_smmu_add_device (2017-08-11 16:56:51 +0200)

----------------------------------------------------------------
IOMMU Fix for Linux v4.13-rc4

	- Fix a NULL-pointer dereference in arm_smmu_add_device

----------------------------------------------------------------
Artem Savkov (1):
      iommu/arm-smmu: fix null-pointer dereference in arm_smmu_add_device

 drivers/iommu/arm-smmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

Please pull.

Thanks,

	Joerg

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJZjdPGAAoJECvwRC2XARrjJzUQAMeOIwrmSsOGsU5ldXTmjq82
SP/Owwo32jd1y4I+4I+hctejr4BUFqow3b4ad4UfnaJFFdE6cDZonmaoheHvsSXp
wTwFBTk6IhoHiXdG6nUrqg6sbhTnNYzGmHZvvTVXpBZFxmKL9dCQMcj7lEefrL6N
xa2jrhgKo7EitFXu2AkmfKmeuFqoQpOvQwI6tDaffIVsOY0iZ++FCMru/rZgMHbf
FfkMyMxqfGBhvx3Sml9YXlyDu7m3+M4JmaSrqTbVOeb7h7DGBdMs2NfajIf57gxX
DP2I66crLlTB6YCkRRIBIzd/Ozd59M0l/T7xZWYEaq+7IZJWYcQq5Fn7XBLc1x1D
tAcpTxY60gaaihekxnO14A7F6+DDOfiroZoc6gqlMJNvbR/bsjcLcXCICgqMzg70
Qsjl20N0eYwA1kWgHIgHD3qZvGi/wgoem3v+Qvrsj8uVeb8I6srtG92RWMwqpNL6
vd10+P7R51K8oeTiBIYjhLCADc07wdKYk4BHYMvG+v/fp+XRHI0XTfr5gzpJLULG
8ETTE1YmyKuNUOKccDcJS/C4CCucyELMcW8B3+i3Kvm41g+lj/SG7U+ZsTTt4LSa
GrUMBLl19HUABNI8KMIsR11LyuIQeCzHEJvAlrwqBEFK7uwoLpYZVALT5CaVhDjT
sBuFNkIEr3Rfp8Vyryta
=o5BA
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
