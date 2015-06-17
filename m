From: Joerg Roedeljoro <joro@8bytes.org>
Subject: Re: Panic when cpu hot-remove
Date: Wed, 17 Jun 2015 13:52:39 +0200
Message-ID: <20150617115238.GC27750@8bytes.org>
References: <42BB8332972FC149B81C55A0D41E3A79C07469@jtjnmailbox06.home.langchao.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <42BB8332972FC149B81C55A0D41E3A79C07469@jtjnmailbox06.home.langchao.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?6IyD5Yas5Yas?= <fandd@inspur.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "jiang.liu@intel.com" <jiang.liu@intel.com>, iommu <iommu@lists.linux-foundation.org>, =?utf-8?B?6Zer5pmT5bOw?= <yanxiaofeng@inspur.com>, =?utf-8?B?5YiY6ZW/55Sf?= <liuchangsheng@inspur.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 17, 2015 at 10:42:49AM +0000, =E8=8C=83=E5=86=AC=E5=86=AC w=
rote:
> Hi maintainer,
>=20
> We found a problem that a panic happen when cpu was hot-removed. We a=
lso trace the problem according to the calltrace information.
> An endless loop happen because value head is not equal to value tail =
forever in the function qi_check_fault( ).
> The location code is as follows:
>=20
>=20
> do {
>         if (qi->desc_status[head] =3D=3D QI_IN_USE)
>         qi->desc_status[head] =3D QI_ABORT;
>         head =3D (head - 2 + QI_LENGTH) % QI_LENGTH;
>     } while (head !=3D tail);

Hmm, this code interates only over every second QI descriptor, and tail
probably points to a descriptor that is not iterated over.

Jiang, can you please have a look?


	Joerg
