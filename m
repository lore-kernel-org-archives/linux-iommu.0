Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A3FC433E4
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 11:18:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92FB720760
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 11:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="PEAhXkGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FB720760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5561488729;
	Thu, 16 Jul 2020 11:18:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gi0mF3P292cZ; Thu, 16 Jul 2020 11:18:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F3D238ABDF;
	Thu, 16 Jul 2020 11:18:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D60C8C0893;
	Thu, 16 Jul 2020 11:18:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D29FFC0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 11:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BEB5F8ABDF
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 11:18:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aA8Gy2g9WIYo for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 11:18:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from lb2-smtp-cloud8.xs4all.net (lb2-smtp-cloud8.xs4all.net
 [194.109.24.25])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CB7A288729
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 11:18:31 +0000 (UTC)
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
 by smtp-cloud8.xs4all.net with ESMTPA
 id w1u6j4ITNNPeYw1uAjUkwP; Thu, 16 Jul 2020 13:18:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
 t=1594898309; bh=LkxHWFBMuZTbBnVOOWxKOK8BVOlu6PpTbe4We/KVE+c=;
 h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
 Subject;
 b=PEAhXkGD1N+XVxXS6SIymAnRUJpqUWWy2eMoSoy2e2aQTuhCMpv+bvNcfsI+1qbn1
 yVN9JGBjND/Q3KwXmyv/whYXfpAfVXU/lrZeDPXqbvpKqzW8tD8baKpQki8IeK+RI8
 aZs86uGUGEA4FstiaUGhyZ2TFZ2YHrgrxnghVHjwvFVPClZC9GjA8xEccEY1Hp0O6m
 Qy1IdA/YNSCycB3GK/ttXNJ32AWtm1paxhHIy81MYI08h4jyyHyemETRaLZiTuHZPb
 1LKoCdBJ215kR6+3cZZLUcZltoArwPqOI+Si+XmrOI0pKtX7DVlkaMz1SyxhrnChC7
 DGN/fTzwvHD6A==
Subject: Re: [PATCH RESEND v9 18/18] media: platform: Add jpeg enc feature
To: Tomasz Figa <tfiga@chromium.org>
References: <20200604090553.10861-1-xia.jiang@mediatek.com>
 <20200604090553.10861-20-xia.jiang@mediatek.com>
 <20200611184640.GC8694@chromium.org> <1593485781.20112.43.camel@mhfsdcap03>
 <20200630165301.GA1212092@chromium.org> <1594104314.4473.24.camel@mhfsdcap03>
 <CAAFQd5CONkGrESiq2hZ9RWZK8FU0av4LjEQi4bc_c5Nu+sRPEA@mail.gmail.com>
 <1594192410.14412.11.camel@mhfsdcap03>
 <CAAFQd5DeV9uEnhKRa9-fcyDK53Zn2meKUg5Nwm3QORz+ZhGpAQ@mail.gmail.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <52445bf0-90b7-c3ff-db52-e1f01a2d9cd1@xs4all.nl>
Date: Thu, 16 Jul 2020 13:18:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAFQd5DeV9uEnhKRa9-fcyDK53Zn2meKUg5Nwm3QORz+ZhGpAQ@mail.gmail.com>
Content-Language: en-US
X-CMAE-Envelope: MS4wfIG/lcK9cmei3Hd1oN/TGBkF/ZZWy5IHHyTruPsn7ixilJ24vB3WG8yc3xyrJj0RBzSTuOo5U7Tv1xWvlx+VTLC8JLJWXEkrSwJkHk0M6OpyUVbHlVfT
 7+6rm9kTbm+RoverBowEglrZC8gXLn7I5erYUKD5EehSZvdRtcuTNh4fc0bWe7aX5RFDNS5bcRzCp1DO6NTQtvu77D5XglRln3kS9uFJE7yM7MS4JTC4AIgY
 p+YiPfJ4+1isvBVisVKglcgRvSJQoemwpFIBeeNnOXslzFPEEvhSoPjKMg6KaBjqbkYQsK1Ss4/eIGFzehVT92Vor+6toAwY6vgIHlExE8GPKgWhGkG38H07
 HmvjGY0w38nY7FjL5CXXcSfZRmCeg+w6gv6Rb/zzQuwEtxKxtiMBDoS8XM3+McjQcebRLUckSiUg0ni47mSDW9B7tYX0/d5EWwMT76HFJx+SvRrNi7bzrra0
 JquC09+gQfbb5IcsSoiLCgwW/pODF1ikyYIc23//HANyOFwAjwVwqORPwzV7IjF1KakB/CqBVhcgvwtyCDRDO9R4avd401M+aWGOERnPiWv9UYGP57E6qQPn
 N2WJTDRgBiEumaAQTy7bKIA4S43TQvL0+jXccEFK8UOCE992YHyVudPyP3jxH7RYntzGbIFWJz1aB5HQ7/p9k8vrzd5D/CyFCoD/wkude0lykBAU14mZMjQ0
 mVgwZiOsAfr3+UC3l08xeFTgRvsvni8RLZFukIlttZRIjjC7YMdN8ErWnBIwpWh/Lw4xk1TPrGyGND54mhj9+hla7QrFgJg/INWGysnzZEQ95BnLPnqqNHKr
 VvDJ2+X0dMYRjc4fTqA2nQOPUKINMWbW4a2KxwPKa9J5+Wgz1J+5ehsUFcrBMEWRkyU1SCdoGXRHj0YvvLo=
Cc: Nicolas Boichat <drinkcat@chromium.org>,
 linux-devicetree <devicetree@vger.kernel.org>, mojahsu@chromium.org,
 srv_heupstream <srv_heupstream@mediatek.com>,
 Rick Chang <rick.chang@mediatek.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= <maoguang.meng@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Xia Jiang <xia.jiang@mediatek.com>, Sj Huang <sj.huang@mediatek.com>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>
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

On 08/07/2020 13:16, Tomasz Figa wrote:
> On Wed, Jul 8, 2020 at 9:14 AM Xia Jiang <xia.jiang@mediatek.com> wrote:
>>
>> On Tue, 2020-07-07 at 15:35 +0200, Tomasz Figa wrote:
>>> On Tue, Jul 7, 2020 at 8:47 AM Xia Jiang <xia.jiang@mediatek.com> wrote:
>>>>
>>>> On Tue, 2020-06-30 at 16:53 +0000, Tomasz Figa wrote:
>>>>> Hi Xia,
>>>>>
>>>>> On Tue, Jun 30, 2020 at 10:56:21AM +0800, Xia Jiang wrote:
>>>>>> On Thu, 2020-06-11 at 18:46 +0000, Tomasz Figa wrote:
>>>>>>> Hi Xia,
>>>>>>>
>>>>>>> On Thu, Jun 04, 2020 at 05:05:53PM +0800, Xia Jiang wrote:
>>>>> [snip]
>>>>>>>> +static void mtk_jpeg_enc_device_run(void *priv)
>>>>>>>> +{
>>>>>>>> +       struct mtk_jpeg_ctx *ctx = priv;
>>>>>>>> +       struct mtk_jpeg_dev *jpeg = ctx->jpeg;
>>>>>>>> +       struct vb2_v4l2_buffer *src_buf, *dst_buf;
>>>>>>>> +       enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
>>>>>>>> +       unsigned long flags;
>>>>>>>> +       struct mtk_jpeg_src_buf *jpeg_src_buf;
>>>>>>>> +       struct mtk_jpeg_enc_bs enc_bs;
>>>>>>>> +       int ret;
>>>>>>>> +
>>>>>>>> +       src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
>>>>>>>> +       dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
>>>>>>>> +       jpeg_src_buf = mtk_jpeg_vb2_to_srcbuf(&src_buf->vb2_buf);
>>>>>>>> +
>>>>>>>> +       ret = pm_runtime_get_sync(jpeg->dev);
>>>>>>>> +       if (ret < 0)
>>>>>>>> +               goto enc_end;
>>>>>>>> +
>>>>>>>> +       spin_lock_irqsave(&jpeg->hw_lock, flags);
>>>>>>>> +
>>>>>>>> +       /*
>>>>>>>> +        * Resetting the hardware every frame is to ensure that all the
>>>>>>>> +        * registers are cleared. This is a hardware requirement.
>>>>>>>> +        */
>>>>>>>> +       mtk_jpeg_enc_reset(jpeg->reg_base);
>>>>>>>> +
>>>>>>>> +       mtk_jpeg_set_enc_dst(ctx, jpeg->reg_base, &dst_buf->vb2_buf, &enc_bs);
>>>>>>>> +       mtk_jpeg_set_enc_src(ctx, jpeg->reg_base, &src_buf->vb2_buf);
>>>>>>>> +       mtk_jpeg_enc_set_config(jpeg->reg_base, ctx->out_q.fmt->hw_format,
>>>>>>>> +                               ctx->enable_exif, ctx->enc_quality,
>>>>>>>> +                               ctx->restart_interval);
>>>>>>>> +       mtk_jpeg_enc_start(jpeg->reg_base);
>>>>>>>
>>>>>>> Could we just move the above 5 functions into one function inside
>>>>>>> mtk_jpeg_enc_hw.c that takes mtk_jpeg_dev pointer as its argument, let's
>>>>>>> say mtk_jpeg_enc_hw_run() and simply program all the data to the registers
>>>>>>> directly, without the extra level of abstractions?
>>>>>> I can move the 5 functions into one function(mtk_jpeg_enc_hw_run()), but
>>>>>> this function will be very long, because it contains computation code
>>>>>> such as setting dst addr, blk_num, quality.
>>>>>> In v4, you have adviced the following architecture:
>>>>>> How about the following model, as used by many other drivers:
>>>>>>
>>>>>> mtk_jpeg_enc_set_src()
>>>>>> {
>>>>>>         // Set any registers related to source format and buffer
>>>>>> }
>>>>>>
>>>>>> mtk_jpeg_enc_set_dst()
>>>>>> {
>>>>>>         // Set any registers related to destination format and buffer
>>>>>> }
>>>>>>
>>>>>> mtk_jpeg_enc_set_params()
>>>>>> {
>>>>>>         // Set any registers related to additional encoding parameters
>>>>>> }
>>>>>>
>>>>>> mtk_jpeg_enc_device_run(enc, ctx)
>>>>>> {
>>>>>>         mtk_jpeg_enc_set_src(enc, src_buf, src_fmt);
>>>>>>         mtk_jpeg_enc_set_dst(enc, dst_buf, dst_fmt);
>>>>>>         mtk_jpeg_enc_set_params(enc, ctx);
>>>>>>         // Trigger the hardware run
>>>>>> }
>>>>>> I think that this architecture is more clear(mtk_jpeg_enc_set_config is
>>>>>> equivalent to mtk_jpeg_enc_set_params).
>>>>>> Should I keep the original architecture or move 5 functions into
>>>>>> mtk_jpeg_enc_hw_run?
>>>>>
>>>>> Sounds good to me.
>>>>>
>>>>> My biggest issue with the code that it ends up introducing one more
>>>>> level of abstraction, but with the approach you suggested, the arguments
>>>>> just accept standard structs, which avoids that problem.
>>>>>
>>>>> [snip]
>>>>>>>> +
>>>>>>>> +       ctx->fh.ctrl_handler = &ctx->ctrl_hdl;
>>>>>>>> +       ctx->colorspace = V4L2_COLORSPACE_JPEG,
>>>>>>>> +       ctx->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
>>>>>>>> +       ctx->quantization = V4L2_QUANTIZATION_DEFAULT;
>>>>>>>> +       ctx->xfer_func = V4L2_XFER_FUNC_DEFAULT;
>>>>>>>
>>>>>>> Since we already have a v4l2_pix_format_mplane struct which has fields for
>>>>>>> the above 4 values, could we just store them there?
>>>>>>>
>>>>>>> Also, I don't see this driver handling the colorspaces in any way, but it
>>>>>>> seems to allow changing them from the userspace. This is incorrect, because
>>>>>>> the userspace has no way to know that the colorspace is not handled.
>>>>>>> Instead, the try_fmt implementation should always override the
>>>>>>> userspace-provided colorspace configuration with the ones that the driver
>>>>>>> assumes.
>>>>>>>
>>>>>>>> +       pix_mp->width = MTK_JPEG_MIN_WIDTH;
>>>>>>>> +       pix_mp->height = MTK_JPEG_MIN_HEIGHT;
>>>>>>>> +
>>>>>>>> +       q->fmt = mtk_jpeg_find_format(V4L2_PIX_FMT_YUYV,
>>>>>>>> +                                     MTK_JPEG_FMT_FLAG_ENC_OUTPUT);
>>>>>>>> +       vidioc_try_fmt(container_of(pix_mp, struct v4l2_format,
>>>>>>>> +                                   fmt.pix_mp), q->fmt);
>>>>>>>> +       q->w = pix_mp->width;
>>>>>>>> +       q->h = pix_mp->height;
>>>>>>>> +       q->crop_rect.width = pix_mp->width;
>>>>>>>> +       q->crop_rect.height = pix_mp->height;
>>>>>>>> +       q->sizeimage[0] = pix_mp->plane_fmt[0].sizeimage;
>>>>>>>> +       q->bytesperline[0] = pix_mp->plane_fmt[0].bytesperline;
>>>>>>>
>>>>>>> Actually, do we need this custom mtk_jpeg_q_data struct? Why couldn't we
>>>>>>> just keep the same values inside the standard v4l2_pix_format_mplane
>>>>>>> struct?
>>>>>> I think that we need mtk_jpeg_q_data struct.If we delete it, how can we
>>>>>> know these values(w, h, sizeimage, bytesperline, mtk_jpeg_fmt) belong to
>>>>>> output or capture(output and capture's sizeimages are different, width
>>>>>> and height are differnt too for jpeg dec )?We have
>>>>>> s_fmt_vid_out_mplane/cap_mplane function to set these values.
>>>>>>
>>>>>> But we can use standard v4l2_pix_format_mplane struct replacing the w, h
>>>>>> bytesperline, sizeimage in mtk_jpeg_q_data struct like this:
>>>>>> struct mtk_jpeg_q_data{
>>>>>>     struct mtk_jpeg_fmt *fmt;
>>>>>>     struct v4l2_pix_format_mplane pix_mp;
>>>>>>     struct v4l2_rect enc_crop_rect
>>>>>> }
>>>>>> Then delete ctx->colorspace ctx->ycbcr_enc ctx->quantization
>>>>>> ctx->xfer_func, becuase v4l2_pix_format_mplane in q_data has contained
>>>>>> them and assign them for out_q and cap_q separately.
>>>>>>
>>>>>> WDYT?
>>>>>
>>>>> Sounds good to me. I was considering just making it like
>>>>>
>>>>> struct mtk_jpeg_ctx {
>>>>>       struct mtk_jpeg_fmt *src_fmt;
>>>>>       struct v4l2_pix_format_mplane src_pix_mp;
>>>>>       struct v4l2_rect src_crop;
>>>>>
>>>>>       struct mtk_jpeg_fmt *dst_fmt;
>>>>>       struct v4l2_pix_format_mplane dst_pix_mp;
>>>>>       struct v4l2_rect dst_crop;
>>>>> };
>>>>>
>>>>> but I like your suggestion as well, as long as custom data structures
>>>>> are not used to store standard information.
>>>>
>>>> Dear Tomasz,
>>>>
>>>> I used the structure like below:
>>>>  struct mtk_jpeg_q_data{
>>>>         struct mtk_jpeg_fmt *fmt;
>>>>         struct v4l2_pix_format_mplane pix_mp;
>>>>         struct v4l2_rect enc_crop_rect
>>>> }
>>>> Then delete ctx->colorspace ctx->ycbcr_enc ctx->quantization
>>>> ctx->xfer_func, becuase v4l2_pix_format_mplane in q_data has contained
>>>> them and assign them for out_q and cap_q separately.
>>>>
>>>> Then the v4l2_compliance test will fail, the fail log as below:
>>>> Format ioctls:
>>>>         test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>>>>         test VIDIOC_G/S_PARM: OK (Not Supported)
>>>>         test VIDIOC_G_FBUF: OK (Not Supported)
>>>>         test VIDIOC_G_FMT: OK
>>>>         test VIDIOC_TRY_FMT: OK
>>>>                 fail: v4l2-test-formats.cpp(836):
>>>> fmt_cap.g_colorspace() != col
>>>>         test VIDIOC_S_FMT: FAIL
>>>>         test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>>>>         test Cropping: OK
>>>>         test Composing: OK (Not Supported)
>>>>         test Scaling: OK (Not Supported)
>>>>
>>>> The source code of  v4l2-test-formats.cpp as below:
>>>>
>>>> static int testM2MFormats(struct node *node)
>>>> {
>>>>         cv4l_fmt fmt_out;
>>>>         cv4l_fmt fmt;
>>>>         cv4l_fmt fmt_cap;
>>>>         __u32 cap_type = node->g_type();
>>>>         __u32 out_type = v4l_type_invert(cap_type);
>>>>         __u32 col, ycbcr_enc, quant, xfer_func;
>>>>
>>>>         fail_on_test(node->g_fmt(fmt_out, out_type));
>>>>         node->g_fmt(fmt_cap, cap_type);
>>>>         fail_on_test(fmt_cap.g_colorspace() != fmt_out.g_colorspace());
>>>>         fail_on_test(fmt_cap.g_ycbcr_enc() != fmt_out.g_ycbcr_enc());
>>>>         fail_on_test(fmt_cap.g_quantization() != fmt_out.g_quantization());
>>>>         fail_on_test(fmt_cap.g_xfer_func() != fmt_out.g_xfer_func());
>>>>         col = fmt_out.g_colorspace() == V4L2_COLORSPACE_SMPTE170M ?
>>>>                 V4L2_COLORSPACE_REC709 : V4L2_COLORSPACE_SMPTE170M;
>>>>         ycbcr_enc = fmt_out.g_ycbcr_enc() == V4L2_YCBCR_ENC_601 ?
>>>>                 V4L2_YCBCR_ENC_709 : V4L2_YCBCR_ENC_601;
>>>>         quant = fmt_out.g_quantization() == V4L2_QUANTIZATION_LIM_RANGE ?
>>>>                 V4L2_QUANTIZATION_FULL_RANGE : V4L2_QUANTIZATION_LIM_RANGE;
>>>>         xfer_func = fmt_out.g_xfer_func() == V4L2_XFER_FUNC_SRGB ?
>>>>                 V4L2_XFER_FUNC_709 : V4L2_XFER_FUNC_SRGB;
>>>>         fmt_out.s_colorspace(col);
>>>>         fmt_out.s_xfer_func(xfer_func);
>>>>         fmt_out.s_ycbcr_enc(ycbcr_enc);
>>>>         fmt_out.s_quantization(quant);
>>>>         node->s_fmt(fmt_out);
>>>>         fail_on_test(fmt_out.g_colorspace() != col);
>>>>         fail_on_test(fmt_out.g_xfer_func() != xfer_func);
>>>>         fail_on_test(fmt_out.g_ycbcr_enc() != ycbcr_enc);
>>>>         fail_on_test(fmt_out.g_quantization() != quant);
>>>>         node->g_fmt(fmt_cap);
>>>>         fail_on_test(fmt_cap.g_colorspace() != col);  // line 836
>>>>         fail_on_test(fmt_cap.g_xfer_func() != xfer_func);
>>>>         fail_on_test(fmt_cap.g_ycbcr_enc() != ycbcr_enc);
>>>>         fail_on_test(fmt_cap.g_quantization() != quant);
>>>> }
>>>>
>>>> It needs that cap's colorspace equals out's colorspace when userspace
>>>> just set out's colorspace and then get cap's colorspace. However, cap's
>>>> colorspace which getted from driver equals V4L2_COLORSPACE_JPEG, because
>>>> the code in g_fmt() like this:
>>>> pix_mp->colorspace = q_data->pix_mp.colorspace;
>>>> pix_mp->ycbcr_enc = q_data->pix_mp.ycbcr_enc;
>>>> pix_mp->xfer_func = q_data->pix_mp.xfer_func;
>>>> pix_mp->quantization = q_data->pix_mp.quantization;
>>>>
>>>> How should I handle this case? Should I store them(colorspace,
>>>> sfer_func, ycbcr_enc, quatization) in ctx as the orinal desin? Then I
>>>> can get them from g_fmt() like this:
>>>> pix_mp->colorspace = ctx->colorspace;
>>>> pix_mp->ycbcr_enc = ctx->ycbcr_enc;
>>>> pix_mp->xfer_func = ctx->xfer_func;
>>>> pix_mp->quantization = ctx->quantization;
>>>
>>> Why would there be any other colorspace accepted? I suppose that the
>>> hardware only supports the JPEG color space, so it shouldn't accept
>>> any other colorspace in TRY_FMT (and thus S_FMT) anyway.
>>>
>>> Still, for correctness, I would suggest propagating the colorspace
>>> (and related) information from OUTPUT format to CAPTURE format in
>>> S_FMT(OUTPUT).
>> Dear Tomasz,
>> If the driver doesn't accept any other colorspace from userspace(means
>> the colorspace always equals V4L2_COLORSPACE_JPEG on my understanding),
>> the v4l2_compliance will fail at line 831:
>>   fail_on_test(fmt_out.g_colorspace() != col); // line 831
>>
>> The v4l2_compliance needs driver can accept other colorspace and capture
>> colorspace equals output colorspace.
>>
>> I try to propagate the colorspace from OUTPUT format to CAPTURE foramt
>> in S_FMT, the compliance test succeed.
>>
>> Should the jpeg driver can accept other colorspace?
> 
> Hans, could you advise on what is the proper behavior regarding
> colorimetry support?

The JPEG encoder doesn't do any colorspace conversion as far as I know,
so to get a valid JPEG out of the encoder the colorspace of the OUTPUT format
has to be the same as how the captured JPEG data is interpreted.

So when userspace sets the output format, then the driver should replace the
colorspace field by V4L2_COLORSPACE_SRGB, xfer_func by V4L2_XFER_FUNC and ycbcr_enc
to V4L2_YCBCR_ENC_601.

What I don't know is if this encoder driver supports both limited and full range
for the YUV data. If so, then it supports both values for that field. If it supports
only limited or full range, then it should replace the quantization field for the
output format with a fixed value as well.

The compliance test doesn't handle JPEG codecs very well when it comes to colorspace.
I'll try to fix this.

Regards,

	Hans
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
