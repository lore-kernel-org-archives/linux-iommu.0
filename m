From: Adam Morrison <mad@cs.technion.ac.il>
Subject: Re: BUG: using smp_processor_id() in preemptible [00000000] code]
Date: Mon, 13 Jun 2016 16:11:39 +0300
Message-ID: <CAHMfzJktLSPZuLJ0R90Zaa6tj+awX9NDO2DPzjxEEJuY0CFV+g@mail.gmail.com>
References: <Pine.LNX.4.44L0.1606091410580.1353-100000@iolanthe.rowland.org>
 <50F437E3-85F7-4034-BAAE-B2558173A2EA@gmail.com> <20160613130651.GA8662@invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20160613130651.GA8662@invalid>
Sender: owner-linux-mm@kvack.org
To: M G Berberich <berberic@fmi.uni-passau.de>
Cc: Nadav Amit <nadav.amit@gmail.com>, iommu@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, linux-mm@kvack.org, Alan Stern <stern@rowland.harvard.edu>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Mon, Jun 13, 2016 at 4:06 PM, M G Berberich
<berberic@fmi.uni-passau.de> wrote:

> Hello,
>
>> >> With 4.7-rc2, after detecting a USB Mass Storage device
>> >>
>> >>  [   11.589843] usb-storage 4-2:1.0: USB Mass Storage device detected
>> >>
>> >> a constant flow of kernel-BUGS is reported (several per second).
>
> [=E2=80=A6]
>
>> > This looks like a bug in the memory management subsystem.  It should b=
e
>> > reported on the linux-mm mailing list (CC'ed).
>>
>> This bug is IOMMU related (mailing list CC=E2=80=99ed) and IIUC already =
fixed.
>
> Not fixed in 4.7-rc3

These patches should fix the issue:

    https://lkml.org/lkml/2016/6/1/310
    https://lkml.org/lkml/2016/6/1/311

I'm not sure why they weren't applied... will ping the maintainers.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
