From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 4/5] ARM: shmobile: r8a7791: Add IPMMU DT nodes
Date: Mon, 31 Mar 2014 15:30:00 +0100
Message-ID: <53397BE8.6030707@codethink.co.uk>
References: <1396049781-12941-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1396049781-12941-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <CAMuHMdV5kV_cz3b1gW7qW_z22JtWd9BpoXN2=_XjBqJfcG-yWQ@mail.gmail.com> <2517875.vv2t3ch4DC@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <2517875.vv2t3ch4DC@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 31/03/14 15:01, Laurent Pinchart wrote:
> Hi Geert,
>
> On Monday 31 March 2014 10:52:28 Geert Uytterhoeven wrote:
>> On Sat, Mar 29, 2014 at 12:36 AM, Laurent Pinchart wrote:
>>> +       ipmmu_sy0: mmu@e6280800 {
>>> +               compatible = "renesas,ipmmu-vmsa";
>>> +               reg = <0 0xe6280800 0 0x800>;
>>
>> Shouldn't this be "reg = <0 0xe6280000 0 0x1000>", i.e. expose both
>> banks?
>>
>> Is there any specific reason you're using the second bank of registers?
>> These may read as zero, depending on the SoC mode.
>
> That's a very good question, and I have no clear answer. According to the
> datasheet the second bank of registers is an alias for the non-secure IPMMU
> registers. It looks like we're running in secure mode (that's what I assume
> the "CPU: All CPU(s) started in SVC mode." kernel log message means), and the
> secure IPMMU didn't seem to be functional when I've tested it.
>
> This requires more investigation, but I'm not familiar with secure mode, and
> the IPMMU documentation is really sparse in that area.

The default for the R8A7790 is to start in secure-svc mode.

I would test it in non-secure SVC but the security framework we
are using blocks access to the IPMMU blocks :/


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
