From: Sedat Dilek <sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Linux-4.19] ThinkPad T470 not booting with "intel_iommu=on"
Date: Thu, 20 Sep 2018 14:03:36 +0200
Message-ID: <CA+icZUW7YjPkZq5VPuwA6LFx9NhBf1hiRRQvN+zJaXHnuHJ7RA@mail.gmail.com>
References: <CA+icZUXnB2LbB-X_pQeM=OQDEVcWQdUr9TLbG1cXnpwuTe=mNw@mail.gmail.com>
Reply-To: sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CA+icZUXnB2LbB-X_pQeM=OQDEVcWQdUr9TLbG1cXnpwuTe=mNw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 5, 2018 at 2:04 PM, Sedat Dilek <sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Joerg,
>
> "intel_ioomu=on" was working fine here on my ThinkPad T470 with
> debian/testing AMD64 with Linux v4.17.y and v4.18.y.
>
> With testing Linux v4.19-rc1 and v4.19-rc2 my machine is not booting -
> black screen.
> These kernels are built with LLVM/Clang v7.0.0rc2 (v4.18.y too).
>
> Furthermore, I switched from GRUB to systemd-boot v239.
>
> [ /boot/efi/loader/entries/debian.conf ]
>
> title Debian GNU/Linux buster/sid [ debian kernel ]
> linux /vmlinuz-4.17.0-3-amd64
> initrd /initrd.img-4.17.0-3-amd64
> options root=UUID=4c2aa544-6e86-44d2-9329-572623867b3d ro intel_iommu=on
>
> [ /boot/efi/loader/entries/debian-llvmlinux.conf ]
>
> title Debian GNU/Linux buster/sid [ llvmlinux kernel (EXPERIMENTAL) ]
> linux /vmlinuz-4.19.0-rc2-3-iniza-llvmlinux
> initrd /initrd.img-4.19.0-rc2-3-iniza-llvmlinux
> options root=UUID=4c2aa544-6e86-44d2-9329-572623867b3d ro
>
> Any hints or hints to debug this?
> Any other kernel boot cheats [1] I can try?
>
> My kernel-config and dmesg output is attached.
>
> Thanks in advance.
>
> Regards,
> - Sedat -
>
>
> Documentation/intel_txt.txt
> Documentation/admin-guide/kernel-parameters.txt
> Documentation/Intel-IOMMU.txt
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt#n1645
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/Intel-IOMMU.txt
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/intel_txt.txt

[ TO JR @ SuSE ]

I still have this issue with Linux v4.19-rc4+.

- Sedat -
