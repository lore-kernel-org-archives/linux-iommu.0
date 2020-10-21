Return-Path: <SRS0=cHqw=D4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F214CC4363A
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 20:36:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BB722249
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 20:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gxrp99jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BB722249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 95CA58745E;
	Wed, 21 Oct 2020 20:36:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uEkba-5p7G2H; Wed, 21 Oct 2020 20:36:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D8B54872AC;
	Wed, 21 Oct 2020 20:36:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C255AC08A1;
	Wed, 21 Oct 2020 20:36:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28CA5C0052
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 20:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 249F186E1D
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 20:36:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tcwejoaFQ2I8 for <iommu@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 20:36:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 31D2686DC1
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 20:36:54 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09LKEhPn103150;
 Wed, 21 Oct 2020 20:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ZVPoJnV7ys/S2zhaIuNFlC/M5y606GF+69f28P/G54s=;
 b=Gxrp99jyobldIjG+CoFPmp4ItSH4F1qDM9mJRMedqqKTOzRWxR9zm5PR+jOwd6cJwhA5
 Op41xcukQ81GLKmgk0FrYyyLaUbmKZeVhz/nYUXhcVqwUmy1E3m8WpsjJ80mNJfiHkaC
 /r1uGYwvc8CXZF8cC7Eb3Q35HwpJL5Wfp/Tkz6LN9qnvXu8M6SrmLUyOQtmTnJJjNXdx
 zEzoppZmZJ/1X89z2BinkW2ZUNOviT2TkHADExPwJ0AoBa+n3XI+uQF+K4cUaKMQSUYV
 YE1EKuts4hIDwcXMi849RlpPBF6uYEykr3knBq6W5X0HkeEIazdmZw8rAChfiEg+kVcH aA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 34ak16k20t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 21 Oct 2020 20:36:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09LKZ0fK100071;
 Wed, 21 Oct 2020 20:36:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 348ahy15my-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Oct 2020 20:36:38 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09LKaYZR031899;
 Wed, 21 Oct 2020 20:36:34 GMT
Received: from [10.39.200.42] (/10.39.200.42)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 21 Oct 2020 13:36:33 -0700
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
To: Arvind Sankar <nivedita@alum.mit.edu>,
 Daniel Kiper <daniel.kiper@oracle.com>
References: <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
 <20200924173801.GA103726@rani.riverdale.lan>
 <c9ab2edf-1aaf-a1c9-92d5-2d37382a3163@oracle.com>
 <20200925191842.GA643740@rani.riverdale.lan>
 <d34c189c-4528-0458-0b84-cfd36dc068b3@oracle.com>
 <20201015182654.lgtht5fd2aaunczu@tomti.i.net-space.pl>
 <20201016205151.GA1618249@rani.riverdale.lan>
 <20201019145153.7b6cg3rzj7g4njz6@tomti.i.net-space.pl>
 <20201019171822.GD2701355@rani.riverdale.lan>
 <20201021152833.b3oys643ckcl5evq@tomti.i.net-space.pl>
 <20201021161837.GA3795579@rani.riverdale.lan>
From: Ross Philipson <ross.philipson@oracle.com>
Autocrypt: addr=ross.philipson@oracle.com; keydata=
 mQENBFtHZ04BCADHhtvMImplKfIEOytU7ZH4haZ9eFAqZpGeIpG9D+pzTCuReM2/49bvgNoI
 e1xuiQFO+UEJ8FjedFjDdqY7fSw3xVdX9gLwD1Rmw0Dadc1w6sGbcoOQLHcglesu+BmcKBtU
 tWQZkzCpEShN4etgZThk8469YnAvO08vNZsrizgrpD90T7mEYiNXxIkX87sPGbnBrL1X7RvZ
 TaRXfE8174W+XVwGEpSiO/GjRgLW8+DFZB5MgXpCR993+U1YT9Lz97/MRzr4hqcOYry6LBYi
 s8dOly4oP7gK15oW8Xap9+ur0Jd8Vy8o99Axq+7yunF+2KE2SwP3/w8H3VDpx7EeDhWDABEB
 AAG0KlJvc3MgUGhpbGlwc29uIDxyb3NzLnBoaWxpcHNvbkBvcmFjbGUuY29tPokBVAQTAQgA
 PgIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBFsN7r6v0OZTCaJ1wdpHdTZHiMYcBQJb
 R2eBBQkJZgGzAAoJENpHdTZHiMYcPYcH/Rlp3/F3P4/2i/W0F4yQDVD6rAkejCws4KlbgC5D
 Slkdvk6j8jOW/HNeIY3n+a3mW0iyyhZlipgYAqkK1loDiDxJjc2eUaHxiYWNLQ4CwIj2EC27
 AWCp6hgwHNWmZrdeNbM/Z6LTFQILx5xzgX+86KNqzFV7gOcAaS2qBVz1D83dgrFZaGaao918
 nvfe+SnImo0GaEf8nVDKgsD2zfzMBkk4q/E0mrEADFXwBHSvNCnVyrCN6Ve0dHWgI7SszUDt
 7v01zbGPR5mRfGuyC9gykd2SDCw5/Q27RMWfaPFL/dtiZBljUzb2yW5jicZAz7zNdDcBSUGR
 r//wxtG4k/dBrMW5AQ0EW0dnTwEIAPelEnLDnfJnHdFR+1Thrvv3Udt/1cjqQfHqH4F8zef/
 MsIcPV1skL7qPUYD+CrbasvmqhlPxtJAtN68inPa70fA2g0PtNmLUH1NBb2e6EjOoVZg9ais
 BWfdYUITZouOXs2zCTFsoNWjTJANnXxexbTf1ZEqfzlVtQK+xAnXl3kiL4Y47VMbgDkGedhw
 3ZMWQ2zMMZqYJkPYhtlTXtedhV91DL1347ULwHsvkUJDZ0gL+WU6tYhsCOOiD61x58PfUiFb
 /WkZEPxb96dSSSWrTlLlBWSSD24RnhfbJjfsXeSu9s4XldmGTDkj7jclMVU1xV0BUfqEwhVn
 xR8FlC+dZvkAEQEAAYkBPAQYAQgAJgIbDBYhBFsN7r6v0OZTCaJ1wdpHdTZHiMYcBQJbR2eB
 BQkJZgGyAAoJENpHdTZHiMYcDIAIAIRJrKjIStRvLsOOCX92s9XJPUjrC/xmtVsqVviyFWIC
 QRPQzDE+bDSvRazudBHmcPW+BOOB5B+p7zKZzOGoZV2peG8oA/Y8oCxOYBtpbBaZ5KJexm/g
 BbnJUwb3uhmKtDShHGUCmtq8MZBJBr6Q6xHprOU8Qnzs9Jea8NVwaz9O226Rrg4XVv/sK1Lh
 ++xZfhi7YqKWdx5vdfdnX1xWe8ma0eXLeCDh3V6Ys+Habw1jEbMuafrcVzAbp1rMt2Lju1ls
 BNAoxeViK7QXWfwGTmGJP++jHmo99gMqEtiohf+37N0oS6uYu6kaE7PxsEcOjWKJxW/DdgwO
 eFq+D6xuiKk=
Message-ID: <a4f999cf-733e-d5a9-254e-3829439dcb2d@oracle.com>
Date: Wed, 21 Oct 2020 16:36:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201021161837.GA3795579@rani.riverdale.lan>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010210142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010210141
Cc: linux-doc@vger.kernel.org, dpsmith@apertussolutions.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, luto@amacapital.net,
 iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, linux-integrity@vger.kernel.org,
 trenchboot-devel@googlegroups.com, tglx@linutronix.de
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 10/21/20 12:18 PM, Arvind Sankar wrote:
> On Wed, Oct 21, 2020 at 05:28:33PM +0200, Daniel Kiper wrote:
>> On Mon, Oct 19, 2020 at 01:18:22PM -0400, Arvind Sankar wrote:
>>> On Mon, Oct 19, 2020 at 04:51:53PM +0200, Daniel Kiper wrote:
>>>> On Fri, Oct 16, 2020 at 04:51:51PM -0400, Arvind Sankar wrote:
>>>>> On Thu, Oct 15, 2020 at 08:26:54PM +0200, Daniel Kiper wrote:
>>>>>>
>>>>>> I am discussing with Ross the other option. We can create
>>>>>> .rodata.mle_header section and put it at fixed offset as
>>>>>> kernel_info is. So, we would have, e.g.:
>>>>>>
>>>>>> arch/x86/boot/compressed/vmlinux.lds.S:
>>>>>>         .rodata.kernel_info KERNEL_INFO_OFFSET : {
>>>>>>                 *(.rodata.kernel_info)
>>>>>>         }
>>>>>>         ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
>>>>>>
>>>>>>         .rodata.mle_header MLE_HEADER_OFFSET : {
>>>>>>                 *(.rodata.mle_header)
>>>>>>         }
>>>>>>         ASSERT(ABSOLUTE(mle_header) == MLE_HEADER_OFFSET, "mle_header at bad address!")
>>>>>>
>>>>>> arch/x86/boot/compressed/sl_stub.S:
>>>>>> #define mleh_rva(X) (((X) - mle_header) + MLE_HEADER_OFFSET)
>>>>>>
>>>>>>         .section ".rodata.mle_header", "a"
>>>>>>
>>>>>> SYM_DATA_START(mle_header)
>>>>>>         .long   0x9082ac5a    /* UUID0 */
>>>>>>         .long   0x74a7476f    /* UUID1 */
>>>>>>         .long   0xa2555c0f    /* UUID2 */
>>>>>>         .long   0x42b651cb    /* UUID3 */
>>>>>>         .long   0x00000034    /* MLE header size */
>>>>>>         .long   0x00020002    /* MLE version 2.2 */
>>>>>>         .long   mleh_rva(sl_stub_entry)    /* Linear entry point of MLE (virt. address) */
>>>>>>         .long   0x00000000    /* First valid page of MLE */
>>>>>>         .long   0x00000000    /* Offset within binary of first byte of MLE */
>>>>>>         .long   0x00000000    /* Offset within binary of last byte + 1 of MLE */
>>>>>>         .long   0x00000223    /* Bit vector of MLE-supported capabilities */
>>>>>>         .long   0x00000000    /* Starting linear address of command line (unused) */
>>>>>>         .long   0x00000000    /* Ending linear address of command line (unused) */
>>>>>> SYM_DATA_END(mle_header)
>>>>>>
>>>>>> Of course MLE_HEADER_OFFSET has to be defined as a constant somewhere.
>>>>>> Anyway, is it acceptable?
>>>>
>>>> What do you think about my MLE_HEADER_OFFSET and related stuff proposal?
>>>>
>>>
>>> I'm wondering if it would be easier to just allow relocations in these
>>> special "header" sections. I need to check how easy/hard it is to do
>>> that without triggering linker warnings.
>>
>> Ross and I still bouncing some ideas. We came to the conclusion that
>> putting mle_header into kernel .rodata.kernel_info section or even
>> arch/x86/boot/compressed/kernel_info.S file would be the easiest thing
>> to do at this point. Of course I would suggest some renaming too. E.g.
>> .rodata.kernel_info to .rodata.kernel_headers, etc. Does it make sense
>> for you?
>>
>> Daniel
> 
> I haven't been able to come up with any different options that don't
> require post-processing of the kernel image. Allowing relocations in
> specific sections seems to not be possible with lld, and anyway would
> require the fields to be 64-bit sized so it doesn't really help.
> 
> Putting mle_header into kernel_info seems like a reasonable thing to me,
> and if you do that, putting it into kernel_info.S would seem to be
> necessary?  Would you also have a fixed field with the offset of the

That seems like a reasonable place for it to go.

> mle_header from kernel_info?  That seems nicer than having the
> bootloader scan the variable data for magic strings.

Yes kernel_info will have a field to the offset of the mle_header. I
agree that would be nicer.

Thanks
Ross

> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
