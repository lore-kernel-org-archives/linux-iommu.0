From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Linux 4.19-rc5: Missing iommu fix
Date: Mon, 24 Sep 2018 11:33:39 +0200
Message-ID: <CA+icZUUdxjVe4p-9aui0cqj_EiHD3O2VZ=dW8HqWf-+9jqnWCA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hi Greg,

thanks and congrats for this release.

Me and several other people have an issue with "intel_iommu=on" (see
[1]) and a patch is pending in [2].
Unfortunately, it is not in linux-iommu Git.
Hope this will soon happen.

Just want to inform you and let people know if they have a similiar problem.

Thanks.

Regards,
- Sedat -


[1] https://www.spinics.net/lists/iommu/msg30105.html
[2] https://lore.kernel.org/patchwork/patch/983690/
