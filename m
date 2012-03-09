From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 07/23] pci, dmar: Update dmar units devices list during hotplug
Date: Fri, 9 Mar 2012 09:32:57 -0800
Message-ID: <CAE9FiQXMhEkMBTjnPJkB21ob9L9jNp_-8_h+xo6mOt3fFQ7xQQ@mail.gmail.com>
References: <1331018040-30725-1-git-send-email-yinghai@kernel.org>
	<1331018040-30725-8-git-send-email-yinghai@kernel.org>
	<CAErSpo6jqr44JS4Cyfc0cR_TNbo_ETjPJUO=x2gj-Q_x4TckVA@mail.gmail.com>
	<CAE9FiQWPk-s5F5ofO=nU05tnRhmpav+f8Cs_mBG9A-MPuK9stw@mail.gmail.com>
	<CAErSpo5QGqW8OL10H_PajnWi0JT=UsfX4c6pXJ_hsqXPcd+NPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo5QGqW8OL10H_PajnWi0JT=UsfX4c6pXJ_hsqXPcd+NPw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 9, 2012 at 9:25 AM, Bjorn Helgaas <bhelgaas@google.com> wro=
te:
>
> Well, it looks like you can change both save_dev_dmaru() *and*
> get_dev_dmaru() to take a struct pci_dev *. =A0I assumed that would b=
e
> obvious.

no.

get_dev_dmaru() have to use bus/devfn to retrieve the dev pointer.

Yinghai
