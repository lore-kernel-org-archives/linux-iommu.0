From: Nadav Amit <nadav.amit@gmail.com>
Subject: Re: BUG: using smp_processor_id() in preemptible [00000000] code]
Date: Thu, 9 Jun 2016 12:10:47 -0700
Message-ID: <50F437E3-85F7-4034-BAAE-B2558173A2EA@gmail.com>
References: <Pine.LNX.4.44L0.1606091410580.1353-100000@iolanthe.rowland.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.44L0.1606091410580.1353-100000@iolanthe.rowland.org>
Sender: owner-linux-mm@kvack.org
To: iommu@lists.linux-foundation.org, Adam Morrison <mad@cs.technion.ac.il>, M G Berberich <berberic@fmi.uni-passau.de>
Cc: USB list <linux-usb@vger.kernel.org>, linux-mm@kvack.org, Alan Stern <stern@rowland.harvard.edu>
List-Id: iommu@lists.linux-foundation.org

Alan Stern <stern@rowland.harvard.edu> wrote:

> On Thu, 9 Jun 2016, M G Berberich wrote:
>=20
>> Hello,
>>=20
>> With 4.7-rc2, after detecting a USB Mass Storage device
>>=20
>>  [   11.589843] usb-storage 4-2:1.0: USB Mass Storage device detected
>>=20
>> a constant flow of kernel-BUGS is reported (several per second).
>>=20
>> [   11.599215] BUG: using smp_processor_id() in preemptible =
[00000000] code:
>> systemd-udevd/389
>> [   11.599218] caller is debug_smp_processor_id+0x17/0x20
>> [   11.599220] CPU: 4 PID: 389 Comm: systemd-udevd Not tainted =
4.7.0-rc2 #6
>> [   11.599220] Hardware name: Gigabyte Technology Co., Ltd. =
H87-HD3/H87-HD3,
>> BIOS F10 08/18/2015
>> [   11.599223]  0000000000000000 ffff88080466b6c8 ffffffff813fc42d
>> 0000000000000004
>> [   11.599224]  ffffffff81cc1da3 ffff88080466b6f8 ffffffff8141a0f6
>> 0000000000000000
>> [   11.599226]  ffff880809fe8d98 0000000000000001 00000000000fffff
>> ffff88080466b708
>> [   11.599226] Call Trace:
>> [   11.599229]  [<ffffffff813fc42d>] dump_stack+0x4f/0x72
>> [   11.599231]  [<ffffffff8141a0f6>] =
check_preemption_disabled+0xd6/0xe0
>> [   11.599233]  [<ffffffff8141a117>] debug_smp_processor_id+0x17/0x20
>> [   11.599235]  [<ffffffff814f0336>] alloc_iova_fast+0xb6/0x210
>> [   11.599238]  [<ffffffff819ed64f>] ? __wait_on_bit+0x6f/0x90
>> [   11.599240]  [<ffffffff814f388d>] intel_alloc_iova+0x9d/0xd0
>> [   11.599241]  [<ffffffff814f7c33>] __intel_map_single+0x93/0x190
>> [   11.599242]  [<ffffffff814f7d64>] intel_map_page+0x34/0x40
>>=20
>> Please see https://bugzilla.kernel.org/show_bug.cgi?id=3D119801 for a
>> more complete kernel-log
>=20
> This looks like a bug in the memory management subsystem.  It should =
be=20
> reported on the linux-mm mailing list (CC'ed).

This bug is IOMMU related (mailing list CC=E2=80=99ed) and IIUC already =
fixed.

Regards,
Nadav


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
